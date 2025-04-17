import 'package:get/get.dart';
import 'package:memberlike/modules/about/about.dart';
import 'package:memberlike/modules/about/about_view.dart';
import 'package:memberlike/modules/auth/signin/signin_screen.dart';
import 'package:memberlike/modules/category/category_binding.dart';
import 'package:memberlike/modules/category/category_view.dart';
import 'package:memberlike/modules/faq/faq_binding.dart';
import 'package:memberlike/modules/faq/faq_view.dart';
import 'package:memberlike/modules/language/lang_binding.dart';
import 'package:memberlike/modules/main/maintanace_screen.dart';
import 'package:memberlike/modules/order_detail/order_detail_binding.dart';
import 'package:memberlike/modules/orders/orders_binding.dart';
import 'package:memberlike/modules/orders/orders_view.dart';
import 'package:memberlike/modules/terms/terms_view.dart';
import 'package:memberlike/modules/profile/profile_binding.dart';
import 'package:memberlike/modules/profile/profile_view.dart';
import 'package:memberlike/modules/wallet/wallet.dart';
import 'package:memberlike/modules/wallet/wallet_view.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/login/login_screen.dart';
import '../modules/language/lang_screen.dart';
import '../modules/main/home_binding.dart';
import '../modules/main/home_screen.dart';
import '../modules/notifications/notification.dart';
import '../modules/notifications/notification_screen.dart';
import '../modules/order_detail/order_detail_view.dart';
import '../modules/product/components/product_view.dart';
import '../modules/product/product_binding.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/ticketing/ticket_binding.dart';
import '../modules/ticketing/ticket_view.dart';

part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ORDERDETAIL,
      page: () => OrderDetail(),
      binding: OrderDetailBinding(),
    ),
    GetPage(
      name: Routes.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: Routes.TICKET,
      page: () => TicketView(),
      binding: TicketBinding(),
    ),
    GetPage(
      name: Routes.WALLET,
      page: () => const WalletView(),
      binding: WalletBinding(),
    ),
    GetPage(
      name: Routes.LOG_IN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.LANGUAGE,
      page: () => LanguageScreen(),
      binding: LangBinding(),
    ),
    GetPage(
      name: Routes.SIGN_UP,
      page: () => SigninScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.MAINTANACE,
      page: () => const MaintanaceScreen(),
      //binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.NOTIFICATION,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: Routes.PRODUCTS,
      page: () => ProductsScreen(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.CATEGORY,
      page: () => CategoryView(),
      binding: CategoryBinding(),
    ),
    GetPage(
      name: Routes.FAQ,
      page: () => const FaqView(),
      binding: FaqBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ABOUTUS,
      page: () => AboutUsPage(),
      binding: AboutusBinding(),
    ),
    GetPage(
      name: Routes.OURTERMS,
      page: () => OurTermsPage(),
      binding: AboutusBinding(),
    ),
  ];
}
