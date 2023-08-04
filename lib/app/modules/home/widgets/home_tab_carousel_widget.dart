import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeTabCarouselWidget extends GetWidget<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Obx(() {
        return ListView.builder(
            primary: false,
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            itemCount: controller.homeTabs.length,
            itemBuilder: (_, index) {
              var _homeTab = controller.homeTabs.elementAt(index);
              return InkWell(
                onTap: () {
                  controller.onHomeTap(_homeTab);
                },
                child: Container(
                  width: 130,
                  margin: EdgeInsetsDirectional.only(end: 20, start: index == 0 ? 20 : 0),
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: _homeTab.isSelected ? Get.theme.colorScheme.secondary : Get.theme.primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Get.theme.focusColor.withOpacity(0.08),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                            ),
                      ],
                      //border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))
                      ),
                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(top: 20,start: 0,end: 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(_homeTab.imgPath,
                          fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.only(start: 3, top: 0),
                        child: Text(
                          _homeTab.text,
                          maxLines: 2,
                          textAlign: TextAlign.start,
                          style: Get.textTheme.bodyMedium?.merge(TextStyle( color: _homeTab.isSelected ? Colors.white : Get.theme.hintColor.withOpacity(0.7))),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
