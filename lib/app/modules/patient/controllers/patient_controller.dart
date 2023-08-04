import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../../common/ui.dart';
import '../../../models/patient_model.dart';
import '../../../repositories/patient_repository.dart';
import '../../../services/auth_service.dart';
import '../../root/controllers/root_controller.dart';


class PatientController extends GetxController {
  final patient = Patient().obs;
  late GlobalKey<FormState> patientForm ;
  final loading = false.obs;

  final isAddressLoading = false.obs;

  var selectedGender = "Male".obs;
  List<String> genders = ["Male","Female"];
  late PatientRepository _patientRepository;


  late bool isFromBooking;



  PatientController() {
    _patientRepository = new PatientRepository();
  }

@override
  void onInit() {
    super.onInit();
    isFromBooking = Get.arguments?['is_from_booking'] ?? false;
  }

  List<DropdownMenuItem<String>> getSelectGenderItem() {
    return genders.map((element) {
      return DropdownMenuItem(
          value:element,
          child:Text(element)
      );
    }).toList();
  }

  void createPatientForm() async {
    Get.focusScope?.unfocus();
    if (patientForm.currentState?.validate() ?? false) {
      try {
        patientForm.currentState?.save();
        if(Helper.getPhoneNumber(patient.value.phone_number ?? '').number.isEmpty) {
          Get.showSnackbar(Ui.ErrorSnackBar(message: "Mobile number must not be empty".tr));
          return;
        }
        loading.value = true;
        patient.value.user_id = Get.find<AuthService>().user.value.id;
        await _patientRepository.create(patient.value);
        if(!isFromBooking) {
          Get.find<RootController>().changePage(3);
          Get.showSnackbar(Ui.SuccessSnackBar(message: "Patient saved successfully".tr));
        } else {
          Get.back(result: isFromBooking);
        }

      } catch (e) {
        Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        loading.value = false;
      }
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(message: "There are errors in some fields please correct them!".tr));
    }
  }

  void resetPatientForm() {
    patientForm.currentState?.reset();
  }

  // Future<void> deletePatient(String PatientID) async {
  //   try {
  //     await _patientRepository.deletePatient(PatientID);
  //   } catch (e) {
  //     Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
  //   }
  // }
}
