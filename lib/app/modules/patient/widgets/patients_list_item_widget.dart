/*
 * Copyright (c) 2020 .
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/patient_model.dart';
import '../../../routes/app_routes.dart';

class PatientsListItemWidget extends StatelessWidget {
  const PatientsListItemWidget({
    Key? key,
    required Patient patient,
  })  : _patient = patient,
        super(key: key);

  final Patient _patient;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.PATIENT_FORM, arguments: {'patient': _patient, 'heroTag': 'patient'});
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: Ui.getBoxDecoration(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                height: 90,
                width: 80,
                fit: BoxFit.cover,
                imageUrl: _patient.firstImageThumb,
                placeholder: (context, url) => Image.asset(
                  'assets/img/loading.gif',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 80,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error_outline),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Wrap(
                runSpacing: 10,
                alignment: WrapAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              _patient.first_name ?? '',
                              style: Get.textTheme.bodyMedium,
                              maxLines: 3,
                              // textAlign: TextAlign.end,
                            ),
                            SizedBox(width: 3,),
                            Text(
                              _patient.last_name ?? '',
                              style: Get.textTheme.bodyMedium,
                              maxLines: 3,
                              // textAlign: TextAlign.end,
                            ),
                          ],
                        ),

                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    children: [
                      Icon(
                        Icons.account_box,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          _patient.age ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    children: [
                      Icon(
                        Icons.man,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          _patient.fatherName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    children: [
                      Icon(
                        Icons.woman,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          _patient.motherName ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  if(_patient.address?.isNotEmpty ?? false) ...{
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          size: 18,
                          color: Get.theme.focusColor,
                        ),
                        SizedBox(width: 3),
                        Flexible(
                          child: Text(
                            _patient.address ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: Get.textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 8, thickness: 1),
                  },
                  Row(
                    children: [
                      Icon(
                        Icons.credit_card,
                        size: 18,
                        color: Get.theme.focusColor,
                      ),
                      SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          _patient.aadhaarNo ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                  Divider(height: 8, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Total Appointments ".tr+"("+_patient.total_appointments.toString()+")",
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Get.textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
