import 'package:get/get.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/base/orders/orders_result/orders_result.dart';
import 'package:quitanda/src/pages/base/orders/repository/orders_repository.dart';
import 'package:quitanda/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  final AuthController authController = Get.find<AuthController>();
  final UtilsServices utilsServices = UtilsServices();

  final OrdersRepository ordersRepository = OrdersRepository();
  List<OrderModel> allOrders = [];

  @override
  void onInit() {
    super.onInit();

    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.getAllOrder(
      userId: authController.user.id!,
      token: authController.user.token!,
    );

    result.when(success: (orders) {
      allOrders = orders
        ..sort((a, b) => b.createdDateTime!.compareTo(a.createdDateTime!));
      update();
    }, error: (message) {
      utilsServices.showCustomToast(
        message: message,
        isError: true,
        context: Get.context!,
      );
    });
  }
}
