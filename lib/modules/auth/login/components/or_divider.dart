import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../shared/constants/common.dart';
import '../../../../shared/utils/size_utils.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: getPadding(left: 40, right: 40),
        child: Row(
          children: [
            Expanded(
              child: Divider(thickness: 0.5, color: Colors.grey.shade400),
            ),
            Padding(
              padding: getPadding(left: 6, right: 6),
              child: Text(
                CommonConstants.or.tr,
                style: TextStyle(color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              child: Divider(thickness: 0.5, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
