import 'package:doctors_appointments/app/models/home_tab_model/index.dart';
import 'package:doctors_appointments/app/routes/app_routes.dart';
import 'package:doctors_appointments/common/helper.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/address_model.dart';
import '../../../models/clinic_model.dart';
import '../../../models/speciality_model.dart';
import '../../../models/doctor_model.dart';
import '../../../models/slide_model.dart';
import '../../../repositories/clinic_repository.dart';
import '../../../repositories/speciality_repository.dart';
import '../../../repositories/doctor_repository.dart';
import '../../../repositories/slider_repository.dart';
import '../../../services/settings_service.dart';
import '../../root/controllers/root_controller.dart';

class HomeController extends GetxController {
  late SliderRepository _sliderRepo;
  late SpecialityRepository _specialityRepository;
  late DoctorRepository _doctorRepository;
  late ClinicRepository _clinicRepository;

  final addresses = <Address>[].obs;
  final sliderTop = <Slide>[].obs;
  final sliderMid = <Slide>[].obs;
  final currentTopSlide = 0.obs;
  final currentMidSlide = 0.obs;

  final clinics = <Clinic>[].obs;
  final doctors = <Doctor>[].obs;
  final specialities = <Speciality>[].obs;
  final featured = <Speciality>[].obs;
  final homeTabs = [
    HomeTabModel(text: 'OPD', isSelected: true, imgPath: 'assets/icon/medical_team.png',),
    HomeTabModel(text: 'Emergency', imgPath: 'assets/icon/siren.png'),
    HomeTabModel(text: 'Blood Bank', imgPath: 'assets/icon/blood_bag.png'),
    HomeTabModel(text: 'Reports', imgPath: 'assets/icon/medical_history.png'),
    HomeTabModel(text: 'Lab Diagnosis', imgPath: 'assets/icon/microscope.png'),
  ].obs;


  HomeController() {
    _sliderRepo = new SliderRepository();
    _specialityRepository = new SpecialityRepository();
    _doctorRepository = new DoctorRepository();
    _clinicRepository = new ClinicRepository();
  }

  @override
  Future<void> onInit() async {
    getCurrentLocation();
    await refreshHome();
    super.onInit();
  }

  Future refreshHome({bool showMessage = false}) async {
    await getSlider();
    await getRecommendedClinics();
    await getRecommendedDoctors();
    await getSpecialities();
    await getFeatured();
    Get.find<RootController>().getNotificationsCount();
    if (showMessage) {
      Get.showSnackbar(Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  Address get currentAddress {
    return Get.find<SettingsService>().address.value;
  }

  Future getSlider() async {
    try {
      Map<String, List<Slide>> slides = await _sliderRepo.getHomeSlider();
      sliderTop.assignAll(slides['slide_top'] as Iterable<Slide>);
      sliderMid.assignAll(slides['slide_mid'] as Iterable<Slide>);
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getSpecialities() async {
    try {
      specialities.assignAll(await _specialityRepository.getAllParents());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getFeatured() async {
    try {
      featured.assignAll(await _specialityRepository.getFeatured());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future getRecommendedDoctors() async {
    try {
      doctors.assignAll(await _doctorRepository.getRecommended());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }
  Future getRecommendedClinics() async {
    try {
      clinics.assignAll(await _clinicRepository.getRecommended());
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  void onHomeTap(HomeTabModel homeTab) {
    if(homeTab.text == 'OPD') {
      Get.toNamed(Routes.MAPS);
    } else if(homeTab.text == 'Emergency') {
      Get.toNamed(Routes.SPECIALITIES, arguments: {
        'is_emergency': '1'
      });
    } else if(!homeTab.isSelected) {
      if(Get.isSnackbarOpen) {
        Get.back();
      }
      Get.showSnackbar(Ui.defaultSnackBar(title: 'Coming soon...', seconds: 1));
    }
  }

  void getCurrentLocation() async {
    final address = Get.find<SettingsService>().address.value;

    if(address.isUnknown()) {
      final tempAddress = await Helper.getCurrentLocation();
      if(tempAddress != null)
        Get.find<SettingsService>().address.value = tempAddress;
    }
  }
}
