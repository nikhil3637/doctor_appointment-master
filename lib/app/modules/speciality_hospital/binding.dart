import 'package:get/get.dart';

import 'controller.dart';

class SpecialityHospitalBinding extends Bindings {
  @override
  void dependencies() {
  Get.lazyPut(() => SpecialityHospitalController());
  }

}