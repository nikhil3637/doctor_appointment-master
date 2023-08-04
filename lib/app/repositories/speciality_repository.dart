import 'package:doctors_appointments/app/models/clinic_model.dart';
import 'package:get/get.dart';

import '../models/speciality_model.dart';
import '../providers/laravel_provider.dart';

class SpecialityRepository {
  late LaravelApiClient _laravelApiClient;

  SpecialityRepository() {
    this._laravelApiClient = Get.find<LaravelApiClient>();
  }

  Future<List<Speciality>> getAll() {
    return _laravelApiClient.getAllSpecialities();
  }

  Future<List<Speciality>> getAllParents() {
    return _laravelApiClient.getAllParentSpecialities();
  }

  Future<List<Speciality>> getAllWithSubSpecialities() {
    return _laravelApiClient.getAllWithSubSpecialities();
  }

  Future<List<Speciality>> getSubSpecialities(String specialityTypeId) {
    return _laravelApiClient.getSubSpecialities(specialityTypeId);
  }

  Future<List<Speciality>> getFeatured() {
    return _laravelApiClient.getFeaturedSpecialities();
  }
}
