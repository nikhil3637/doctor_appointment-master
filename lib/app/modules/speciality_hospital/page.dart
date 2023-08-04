import 'package:doctors_appointments/app/modules/speciality_hospital/widget/clinics_empty_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/ui.dart';
import '../../providers/laravel_provider.dart';
import '../../routes/app_routes.dart';
import '../global_widgets/clinic_availability_badge_widget.dart';
import '../home/widgets/clinic_main_thumb_widget.dart';
import '../home/widgets/clinic_thumbs_widget.dart';
import 'controller.dart';

class SpecialityHospitalView extends GetView<SpecialityHospitalController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: () async {
              Get.find<LaravelApiClient>().forceRefresh();
              controller.getAllHospitals();
              Get.find<LaravelApiClient>().unForceRefresh();
            },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                elevation: 0.5,
                primary: true,
                iconTheme: IconThemeData(color: Get.theme.primaryColor),
                title: Text(
                  "Emergency Hospitals".tr,
                  style: Get.textTheme.titleLarge,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios,
                      color: Colors.black),
                  onPressed: Get.back,
                ),
              ),
              body: Obx(() => getList()),
            )));
  }

  Widget getList() {
    if (controller.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      if (controller.clinics.isEmpty) {
        return ClinicsEmptyListWidget();
      } else {
        return ListView.builder(
            controller: controller.scrollController,
            padding: EdgeInsets.only(bottom: 18),
            shrinkWrap: true,
            itemCount: controller.clinics.length,
            itemBuilder: (_, index) {
              var _clinic = controller.clinics.elementAt(index);
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if(_clinic.doctors?.isNotEmpty ?? false) {
                        _clinic.doctors?.first.clinic = _clinic;
                        Get.toNamed(Routes.BOOK_DOCTOR, arguments: {
                          'doctor': _clinic.doctors?.first,
                          'heroTag': 'recommended_carousel',
                          'is_emergency': _clinic.doctors?.first.id
                        });
                      } else {
                        Get.showSnackbar(Ui.ErrorSnackBar(title: 'Sorry! We\'ve no doctor right now'.tr));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsetsDirectional.only(
                          end: 20, start: index == 0 ? 20 : 0, top: 20, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Get.theme.focusColor.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 5)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClinicMainThumbWidget(clinic: _clinic),
                          SizedBox(height: 2),
                          ClinicThumbsWidget(clinic: _clinic),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 15),
                            height: 110,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  _clinic.name ?? '',
                                  maxLines: 2,
                                  style: Get.textTheme.bodyMedium?.merge(
                                      TextStyle(color: Get.theme.hintColor)),
                                ),
                                Text(
                                  Ui.getDistance(_clinic.distance!),
                                  style: Get.textTheme.bodyLarge,
                                ),
                                SizedBox(height: 8),
                                Wrap(
                                  spacing: 5,
                                  alignment: WrapAlignment.spaceBetween,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  direction: Axis.horizontal,
                                  children: [
                                    Wrap(
                                      children: Ui.getStarsList(_clinic.rate!),
                                    ),
                                    ClinicAvailabilityBadgeWidget(clinic: _clinic),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(controller.loadMore.value && (index == controller.clinics.length - 1)) ...{
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                    const SizedBox(height: 30,)
                  }
                ],
              );
            });
      }
    }
  }
}
