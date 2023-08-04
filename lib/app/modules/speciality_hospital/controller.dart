import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/clinic_model.dart';
import '../../models/speciality_model.dart';
import '../../repositories/clinic_repository.dart';

class SpecialityHospitalController extends GetxController {
  final clinics = <Clinic>[].obs;
  late ClinicRepository _clinicRepository;

  final page = 0.obs;
  final isLoading = true.obs;
  final loadMore = false.obs;
  final isDone = false.obs;

  Speciality speciality = Get.arguments;

  ScrollController scrollController = ScrollController();

  SpecialityHospitalController() {
    _clinicRepository = ClinicRepository();
  }
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value && !loadMore.value) {
        loadMoreHospitals();
      }
    });
    getAllHospitals();
  }

  Future<void> getAllHospitals() async {
    clinics.clear();
    isLoading.value = true;
    isDone.value = false;
    this.page.value = 0;
    clinics.assignAll(await _clinicRepository.getSpecialityClinics(speciality.id!));
    isLoading.value = false;
  }

  Future<void> loadMoreHospitals() async {
    loadMore.value = true;
    isDone.value = false;
    this.page.value++;
    final List<Clinic> clinics = await _clinicRepository.getSpecialityClinics(speciality.id!, page: page.value);
    if(clinics.isEmpty) {
      isDone.value = true;
    } else {
      clinics.assignAll(clinics);
    }
    loadMore.value = false;
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}