import 'package:get/get.dart';
import 'package:quitanda/src/pages/base/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}
