import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/speciality_model.dart';
import '../../../repositories/speciality_repository.dart';

enum SpecialitiesLayout { GRID, LIST }

class SpecialitiesController extends GetxController {
  late SpecialityRepository _specialityRepository;

  final specialities = <Speciality>[].obs;
  final layout = SpecialitiesLayout.LIST.obs;

  String? specialityTypeId = Get.arguments?['is_emergency'];


  SpecialitiesController() {
    _specialityRepository = new SpecialityRepository();
  }

  @override
  Future<void> onInit() async {
    await refreshSpecialities();
    super.onInit();
  }

  Future refreshSpecialities({bool showMessage = false}) async {
    await getSpecialities();
    if (showMessage == true) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "List of specialities refreshed successfully".tr));
    }
  }

  Future getSpecialities() async {
    try {
      if(specialityTypeId == null) {
        specialities.assignAll(await _specialityRepository.getAllWithSubSpecialities());
      } else {
        specialities.assignAll(await _specialityRepository.getSubSpecialities(specialityTypeId!));
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
}
