import 'package:get/get.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/Controller/home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
  }
}
