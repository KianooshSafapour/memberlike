import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/shared/constants/colors.dart';

import '../../app_controller.dart';
import 'common_widget.dart';

class AppCheckbox extends StatefulWidget {
  final String? label;
  final bool? checked;
  final Function(bool?)? onChecked;
  final bool isChangable;

  const AppCheckbox(
      {super.key,
      this.label,
      this.checked,
      this.onChecked,
      this.isChangable = true});

  @override
  _AppCheckboxState createState() => _AppCheckboxState();
}

class _AppCheckboxState extends State<AppCheckbox> {
  bool? _checked = false;

  void _onChecked(bool? checked) {
    widget.isChangable
        ? setState(() {
            _checked = checked;
          })
        : null;

    if (widget.onChecked != null) {
      widget.onChecked!(checked);
    }
  }

  @override
  void initState() {
    _checked = widget.checked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.0,
            height: 24.0,
            child: Checkbox(
                side: WidgetStateBorderSide.resolveWith(
                  (states) => BorderSide(
                      width: 1.0,
                      color: _checked != null && _checked!
                          ? ColorConstants.kPrimaryColor5
                          : Get.find<AppController>().isDarkModeOn.value
                              ? ColorConstants.white
                              : ColorConstants.kSecondColor8),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                activeColor: Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kPrimaryColor5,
                value: _checked,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onChanged: _onChecked),
          ),
          CommonWidget.rowWidth(width: 10.0),
          Flexible(
            child: Text(
              widget.label ?? "",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Get.find<AppController>().isDarkModeOn.value
                    ? ColorConstants.white
                    : ColorConstants.kSecondColor2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
