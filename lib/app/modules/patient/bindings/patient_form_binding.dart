import 'package:get/get.dart';

import '../controllers/patient_controller.dart';
import '../controllers/patient_form_controller.dart';
import '../controllers/patients_controller.dart';

class PatientFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PatientsController>(
          () => PatientsController(),
    );
    Get.lazyPut<PatientFormController>(
          () => PatientFormController(),
    );
  }
}
