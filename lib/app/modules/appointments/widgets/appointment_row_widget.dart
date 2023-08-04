import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentRowWidget extends StatelessWidget {
  const AppointmentRowWidget({
    Key? key,
    required this.description,
    this.value = '',
    this.valueStyle,
    this.hasDivider =false,
    this.child,
    this.descriptionFlex,
    this.valueFlex,
  }) : super(key: key);

  final String description;
  final int? descriptionFlex;
  final int? valueFlex;
  final String value;
  final Widget? child;
  final TextStyle? valueStyle;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: descriptionFlex ?? 1,
              child: Text(
                this.description,
                style: Get.textTheme.bodyLarge,
              ),
            ),
            Expanded(
                flex: valueFlex ?? 1,
                child: child ??
                    Text(
                      value,
                      style: valueStyle ?? Get.textTheme.bodyMedium,
                      maxLines: 3,
                      textAlign: TextAlign.end,
                    )),
          ],
        ),
        if (hasDivider) Divider(thickness: 1, height: 25),
        if (!hasDivider) SizedBox(height: 6),
      ],
    );
  }
}
