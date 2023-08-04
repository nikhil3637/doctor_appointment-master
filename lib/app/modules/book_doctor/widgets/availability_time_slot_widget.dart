import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../global_widgets/tab_bar_widget.dart';
import '../controllers/book_doctor_controller.dart';

class AvailabilityTimeSlotWidget extends GetWidget<BookDoctorController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.loadingSlots.value ? Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(30),
      child: CircularProgressIndicator(),
    ) :
    controller.isNoAppointment() ? Container(
      margin: const EdgeInsets.all(30),
      alignment: Alignment.center,
      child: Opacity(
          opacity: 0.3,
          child: Text("No Appointment Available!".tr, style: Get.textTheme.headlineMedium)),
    ) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(controller.morningTimes.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 5, left: 20, right: 20),
            child: Text("Morning".tr, style: Get.textTheme.bodyMedium),
          ),
          TabBarWidget(
            initialSelectedId: "",
            tag: 'hours',
            tabs: List.generate(controller.morningTimes.length, (index) {
              final _time =
              controller.morningTimes.elementAt(index).elementAt(0);
              return ChipWidget(
                backgroundColor:
                Get.theme.colorScheme.secondary.withOpacity(0.2),
                style: Get.textTheme.bodyLarge?.merge(
                    TextStyle(color: Get.theme.colorScheme.secondary)),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                tag: 'hours',
                text: DateFormat('HH:mm')
                    .format(DateTime.parse(_time).toLocal()),
                id: _time,
                onSelected: (id) {
                  controller.appointment.update((val) {
                    val?.appointmentAt = DateTime.parse(id).toLocal();
                  });
                },
              );
            }),
          ),
        },
        if(controller.afternoonTimes.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 5, left: 20, right: 20),
            child: Text("Afternoon".tr, style: Get.textTheme.bodyMedium),
          ),
          TabBarWidget(
            initialSelectedId: "",
            tag: 'hours',
            tabs: List.generate(controller.afternoonTimes.length, (index) {
              final _time =
              controller.afternoonTimes.elementAt(index).elementAt(0);

              return ChipWidget(
                backgroundColor:
                Get.theme.colorScheme.secondary.withOpacity(0.2),
                style: Get.textTheme.bodyLarge?.merge(
                    TextStyle(color: Get.theme.colorScheme.secondary)),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                tag: 'hours',
                text: DateFormat('HH:mm')
                    .format(DateTime.parse(_time).toLocal()),
                id: _time,
                onSelected: (id) {
                  controller.appointment.update((val) {
                    val?.appointmentAt = DateTime.parse(id).toLocal();
                  });
                },
              );
            }),
          ),
        },
        if(controller.eveningTimes.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 5, left: 20, right: 20),
            child: Text("Evening".tr, style: Get.textTheme.bodyMedium),
          ),
          TabBarWidget(
            initialSelectedId: "",
            tag: 'hours',
            tabs: List.generate(controller.eveningTimes.length, (index) {
              final _time =
              controller.eveningTimes.elementAt(index).elementAt(0);

              return ChipWidget(
                backgroundColor:
                Get.theme.colorScheme.secondary.withOpacity(0.2),
                style: Get.textTheme.bodyLarge?.merge(
                    TextStyle(color: Get.theme.colorScheme.secondary)),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                tag: 'hours',
                text: DateFormat('HH:mm')
                    .format(DateTime.parse(_time).toLocal()),
                id: _time,
                onSelected: (id) {
                  controller.appointment.update((val) {
                    val?.appointmentAt = DateTime.parse(id).toLocal();
                  });
                },
              );
            }),
          ),
        },
        if(controller.nightTimes.isNotEmpty) ...{
          Padding(
            padding: const EdgeInsets.only(
                top: 10, bottom: 5, left: 20, right: 20),
            child: Text("Night".tr, style: Get.textTheme.bodyMedium),
          ),
          TabBarWidget(
            initialSelectedId: "",
            tag: 'hours',
            tabs: List.generate(controller.nightTimes.length, (index) {
              final _time =
              controller.nightTimes.elementAt(index).elementAt(0);

              return ChipWidget(
                backgroundColor:
                Get.theme.colorScheme.secondary.withOpacity(0.2),
                style: Get.textTheme.bodyLarge?.merge(
                    TextStyle(color: Get.theme.colorScheme.secondary)),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                tag: 'hours',
                text: DateFormat('HH:mm')
                    .format(DateTime.parse(_time).toLocal()),
                id: _time,
                onSelected: (id) {
                  controller.appointment.update((val) {
                    val?.appointmentAt = DateTime.parse(id).toLocal();
                  });
                },
              );
            }),
          ),
        }
      ],
    )
    );
  }
}
