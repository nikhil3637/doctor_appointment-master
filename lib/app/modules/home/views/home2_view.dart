import 'package:carousel_slider/carousel_slider.dart';

import 'package:doctors_appointments/app/modules/home/widgets/home_tab_carousel_widget.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/slide_model.dart';
import '../../../providers/laravel_provider.dart';
import '../../../routes/app_routes.dart';
import '../../../services/settings_service.dart';
import '../../global_widgets/address_widget.dart';
import '../../global_widgets/home_search_bar_widget.dart';
import '../../global_widgets/notifications_button_widget.dart';
import '../controllers/home_controller.dart';
import '../widgets/recommended_clinics_carousel_widget.dart';
import '../widgets/specialities_carousel_widget.dart';
import '../widgets/recommended_doctors_carousel_widget.dart';
import '../widgets/slide_item_widget.dart';

class Home2View extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
          onRefresh: () async {
            Get.find<LaravelApiClient>().forceRefresh();
            await controller.refreshHome(showMessage: true);
            Get.find<LaravelApiClient>().unForceRefresh();
          },
          child: CustomScrollView(
            primary: true,
            shrinkWrap: false,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                expandedHeight: 300,
                elevation: 0.5,
                floating: true,
                iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
                title: Text(
                  Get.find<SettingsService>().setting.value.appName ?? '',
                  style: Get.textTheme.titleLarge,
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                leading: new IconButton(
                  icon: new Icon(Icons.sort, color: Colors.black87),
                  onPressed: () => {Scaffold.of(context).openDrawer()},
                ),
                actions: [NotificationsButtonWidget()],
                bottom: HomeSearchBarWidget(),
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Obx(() {
                    return Stack(
                      alignment: controller.sliderTop.isEmpty
                          ? AlignmentDirectional.center
                          : Ui.getAlignmentDirectional(controller.sliderTop.elementAt(controller.currentTopSlide.value).textPosition),
                      children: <Widget>[
                        CarouselSlider(
                          options: CarouselOptions(
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 7),
                            height: 360,
                            viewportFraction: 1.0,
                            onPageChanged: (index, reason) {
                              controller.currentTopSlide.value = index;
                            },
                          ),
                          items: controller.sliderTop.map((Slide slide) {
                            return SlideItemWidget(slide: slide);
                          }).toList(),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: controller.sliderTop.map((Slide slide) {
                              return Container(
                                width: 20.0,
                                height: 5.0,
                                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    color: controller.currentTopSlide.value == controller.sliderTop.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor!.withOpacity(0.4)),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),
                ).marginOnly(bottom: 42),
              ),
              SliverToBoxAdapter(
                child: Wrap(
                  children: [
                    AddressWidget(),

                    HomeTabCarouselWidget(),

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Recommended Hospitals".tr, style: Get.textTheme.headlineSmall)),
                          MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.MAPS);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                            child: Text("View All".tr, style: Get.textTheme.titleMedium),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                     RecommendedClinicsCarouselWidget(),
                    Obx(() {
                      return Stack(
                        alignment: controller.sliderMid.isEmpty
                            ? AlignmentDirectional.center
                            : Ui.getAlignmentDirectional(controller.sliderMid.elementAt(controller.currentTopSlide.value).textPosition),
                        children: <Widget>[
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 7),
                              height: 360,
                              viewportFraction: 1.0,
                              onPageChanged: (index, reason) {
                                controller.currentTopSlide.value = index;
                              },
                            ),
                            items: controller.sliderMid.map((Slide slide) {
                              return SlideItemWidget(slide: slide);
                            }).toList(),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 70, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: controller.sliderMid.map((Slide slide) {
                                return Container(
                                  width: 20.0,
                                  height: 5.0,
                                  margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      color: controller.currentMidSlide.value == controller.sliderMid.indexOf(slide) ? slide.indicatorColor : slide.indicatorColor!.withOpacity(0.4)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      );
                    }),
                    Container(
                      //color: Get.theme.primaryColor,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Recommended Doctors".tr, style: Get.textTheme.headlineSmall)),
                          MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.SPECIALITIES);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                            child: Text("View All".tr, style: Get.textTheme.titleMedium),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                    RecommendedDoctorsCarouselWidget(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Expanded(child: Text("Specialities".tr, style: Get.textTheme.headlineSmall)),
                          MaterialButton(
                            onPressed: () {
                              Get.toNamed(Routes.SPECIALITIES);
                            },
                            shape: StadiumBorder(),
                            color: Get.theme.colorScheme.secondary.withOpacity(0.1),
                            child: Text("View All".tr, style: Get.textTheme.titleMedium),
                            elevation: 0,
                          ),
                        ],
                      ),
                    ),
                    SpecialitiesCarouselWidget(),
                    //FeaturedSpecialitiesWidget(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
