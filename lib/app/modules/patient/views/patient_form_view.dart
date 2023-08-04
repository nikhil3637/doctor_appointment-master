import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/helper.dart';
import '../../../models/media_model.dart';
import '../../global_widgets/gender_field_widget.dart';
import '../../global_widgets/images_field_widget.dart';
import '../../global_widgets/phone_field_widget.dart';



import '../../global_widgets/text_fleld_widget/index.dart';

import '../controllers/patient_form_controller.dart';
import '../widgets/delete_patient_widget.dart';

class PatientFormView extends GetView<PatientFormController> {

  @override
  Widget build(BuildContext context) {
    controller.patientForm = new GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Edit Patient".tr,
            style: context.textTheme.titleLarge,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
            onPressed: Get.back
          ),
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    controller.updatePatientForm();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: Get.theme.colorScheme.secondary,
                  child: Text("Save".tr, style: Get.textTheme.bodyMedium?.merge(TextStyle(color: Get.theme.primaryColor))),
                  elevation: 0,
                  highlightElevation: 0,
                  hoverElevation: 0,
                  focusElevation: 0,
                ),
              ),
              SizedBox(width: 10),
              MaterialButton(
                onPressed: () {
                  controller.resetPatientForm();
                },
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                color: Get.theme.hintColor.withOpacity(0.1),
                child: Text("Reset".tr, style: Get.textTheme.bodyMedium),
                elevation: 0,
                highlightElevation: 0,
                hoverElevation: 0,
                focusElevation: 0,
              ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: controller.patientForm,
          child: SingleChildScrollView(
            primary: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Patient details".tr, style: Get.textTheme.headlineSmall).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
                Text("Change the following details and save them".tr, style: Get.textTheme.bodySmall).paddingSymmetric(horizontal: 22, vertical: 5),
                Obx(() {
                  return ImagesFieldWidget(
                    label: "Images".tr,
                    field: 'image',
                    tag: controller.patientForm.hashCode.toString(),
                    initialImages: controller.patient.value.images,
                    uploadCompleted: (uuid) {
                      controller.patient.update((val) {
                        val?.images = val.images ?? [];
                        val?.images?.add(new Media(id: uuid));
                      });
                    },
                    reset: (uuids) {
                      controller.patient.update((val) {
                        val?.images?.clear();
                      });
                    },
                  );
                }),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.first_name = input,
                  // onChanged: (input) => controller.patient.value.first_name = input,
                  validator: (input) => (input?.length ?? 0) < 3 ? "Should be more than 3 letters".tr : null,
                  initialValue: controller.patient.value.first_name ?? '',
                  hintText: "John Doe".tr,
                  labelText: "First Name".tr,
                  iconData: Icons.person_outline,
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.last_name = input,
                  // onChanged: (input) => controller.patient.value.last_name = input,
                  validator: (input) => (input?.length ?? 0) < 3 ? "Should be more than 3 letters".tr : null,
                  initialValue: controller.patient.value.last_name ?? '',
                  hintText: "John Doe".tr,
                  labelText: "Last Name".tr,
                  iconData: Icons.person_outline,
                ),
                PhoneFieldWidget(
                  labelText: "Phone Number".tr,
                  hintText: "223 665 7896".tr,
                  // initialCountryCode: Helper.getPhoneNumber(controller.patient.value.phone_number ?? '').countryISOCode ?? '',
                  initialValue: Helper.getPhoneNumber(controller.patient.value.phone_number ?? '').number ,
                  onChanged: (phone) {
                    controller.patient.value.phone_number = phone.completeNumber;
                  },
                  onSaved: (phone) {
                    controller.patient.value.phone_number = phone?.completeNumber;
                  },
                ),
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.age = input,
                  // onChanged: (input) => controller.patient.value.age = input,
                  // validator: (input) => (input?.length ?? 0) < 1 ? "Should be more than 1 number".tr : null,
                  initialValue: controller.patient.value.age ?? '',
                  keyboardType: TextInputType.text,
                  hintText: "55".tr,
                  labelText: "Age".tr,
                  iconData: Icons.account_box,
                ),
                /// Father Name
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.fatherName = input,
                  // validator: (input) => input!.length < 1 ? "Should be not be empty".tr : null,
                  initialValue: controller.patient.value.fatherName ?? '',
                  keyboardType: TextInputType.text,
                  hintText: "Enter Father Name".tr,
                  labelText: "Father Name".tr,
                  iconData: Icons.man,
                ),
                /// Mother Name
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.motherName = input,
                  // validator: (input) => input!.length < 1 ? "Should be not be empty".tr : null,
                  initialValue: controller.patient.value.motherName ?? '',
                  keyboardType: TextInputType.text,
                  hintText: "Enter Mother Name".tr,
                  labelText: "Mother Name".tr,
                  iconData: Icons.woman,
                ),
                /// Address
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.address = input,
                  // validator: (input) => input!.length < 1 ? "Should be not be empty".tr : null,
                  initialValue: controller.patient.value.address ?? '',
                  keyboardType: TextInputType.text,
                  hintText: "Enter Address".tr,
                  labelText: "Address".tr,
                  iconData: Icons.location_pin,
                ),
                /// Aadhaar Card
                TextFieldWidget(
                  onSaved: (input) => controller.patient.value.aadhaarNo = input,
                  // validator: (input) => input!.length < 1 ? "Should be not be empty".tr : input.length < 12 ? "Should be equal to 12 in length".tr : null,
                  initialValue: controller.patient.value.aadhaarNo ?? '',
                  keyboardType: TextInputType.number,
                  hintText: "Enter Aadhaar No.".tr,
                  labelText: "Aadhaar No.".tr,
                  iconData: Icons.credit_card_outlined,
                ),
               Obx((){
                 return GenderFieldWidget(
                   items: controller.getSelectGenderItem(),
                   iconData: Icons.male_rounded,
                   onChanged: (selectedValue) {
                     controller.selectedGender.value = selectedValue.toString();
                   },
                   onSaved: (selectedValue) {
                     controller.patient.value.gender = selectedValue.toString();
                   },
                   value: controller.selectedGender.value,
                   labelText:"Gender".tr,
                 );
               }),
                DeletePatientWidget(),

              ],
            ),

          ),
        ));
  }
}
