import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memberlike/app/modules/category/category.dart';
import 'package:memberlike/app/modules/category/category_view.dart';
import 'package:memberlike/app/modules/profile/profile.dart';
import 'package:memberlike/app/modules/profile/profile_view.dart';
import 'package:memberlike/app/modules/ticketing/ticket_controller.dart';
import 'package:memberlike/app/modules/ticketing/ticket_view.dart';
import 'package:memberlike/app/modules/wallet/wallet.dart';
import 'package:memberlike/app/modules/wallet/wallet_view.dart';

import '../../../app_controller.dart';
import '../../../shared/constants/colors.dart';
import '../../../shared/constants/common.dart';
import '../../../shared/widgets/custom_bottom_navigation_bar.dart';
import 'components/home_view.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  final AppController appController = Get.find();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (controller.bottomNavIndex.value != 0) {
          controller.setValueBottomIndex(0);
          return false;
        }
        return controller.onWillPop();
      },
      child: Obx(
        () => Scaffold(
          //resizeToAvoidBottomInset: true,
          // backgroundColor:
          //     Get.find<AppController>().isDarkModeOn.value
          //         ? ColorConstants.darkScaffoldBackgroundColor
          //         : Colors.white,
          body: IndexedStack(
            index: controller.bottomNavIndex.value,
            children: _widgetOptions(),
          ),
          bottomNavigationBar: _bottomNav(controller),
        ),
      ),
    );
  }

  Widget _bottomNav(HomeController controller) {
    return Obx(
      () => CustomBottomNavigationBar(
        selectedIndex: controller.bottomNavIndex.value,
        color:
            appController.isDarkModeOn.value
                ? ColorConstants.kSecondColor6
                : ColorConstants.darkScaffoldBackgroundColor,
        backgroundColor:
            appController.isDarkModeOn.value
                ? ColorConstants.darkScaffoldBackgroundColor
                : ColorConstants.white,
        selectedColor:
            appController.isDarkModeOn.value
                ? ColorConstants.colorDarkModeBlue
                : ColorConstants.kPrimaryColor,
        notchedShape: const CircularNotchedRectangle(),
        onTabSelected: (value) {
          switch (value) {
            case 0:
              break;
            case 1:
              Get.find<CategoryController>().getServices();
              break;
            case 2:
              {
                if (Get.find<WalletController>().transactions.isEmpty) {
                  Get.find<WalletController>().getTransactions();
                }
                Get.find<WalletController>().getBalance(force: true);
              }
              break;
            case 3:
              Get.find<TicketController>().getTickets();
              break;
            case 4:
              Get.find<ProfileController>().getUserInfo();
              //  Get.toNamed(Routes.PROFILE);
              break;
          }
          controller.setValueBottomIndex(value);
        },
        items: [
          BottomBarItem(
            iconData:
                controller.bottomNavIndex.value == 0
                    ? controller.bottomNavSelectedIconPaths[0]
                    : controller.imagePaths[0],
            text: CommonConstants.home.tr,
          ),
          BottomBarItem(
            iconData:
                controller.bottomNavIndex.value == 1
                    ? controller.bottomNavSelectedIconPaths[1]
                    : controller.imagePaths[1],
            text: "category".tr,
          ),
          BottomBarItem(
            iconData:
                controller.bottomNavIndex.value == 2
                    ? controller.bottomNavSelectedIconPaths[2]
                    : controller.imagePaths[2],
            text: "wallet".tr,
          ),
          BottomBarItem(
            iconData:
                controller.bottomNavIndex.value == 3
                    ? controller.bottomNavSelectedIconPaths[3]
                    : controller.imagePaths[3],
            text: "support".tr,
          ),
          BottomBarItem(
            iconData:
                controller.bottomNavIndex.value == 4
                    ? controller.bottomNavSelectedIconPaths[4]
                    : controller.imagePaths[4],
            text: CommonConstants.profile.tr,
          ),
        ],
      ),
    );
  }

  List<Widget> _widgetOptions() {
    return [
      const HomeView(),
      CategoryView(),
      const WalletView(),
      TicketView(),
      ProfileView(),
    ];
  }
}
