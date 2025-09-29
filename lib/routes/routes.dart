import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/Binding/home_screen_binding.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/home_screen.dart';

class AppRoutes {
  static const homeScreen = "/home";
  static const secondScreen = "/second_screen";

  static final List<GetPage> pages = [
    GetPage(
        name: homeScreen,
        page: () => const HomeScreen(),
        binding: HomeScreenBinding()),
  ];
}
