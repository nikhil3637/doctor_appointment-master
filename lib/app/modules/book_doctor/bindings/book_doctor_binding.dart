import 'package:get/get.dart';

import '../controllers/book_doctor_controller.dart';

class BookDoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookDoctorController>(
      () => BookDoctorController(),
    );
  }
}
