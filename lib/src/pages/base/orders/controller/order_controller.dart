// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';
import 'package:quitanda/src/models/cart_item_model.dart';

import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/base/orders/orders_result/orders_result.dart';
import 'package:quitanda/src/pages/base/orders/repository/orders_repository.dart';
import 'package:quitanda/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;

  OrderController({
    required this.order,
  });

  final AuthController authController = Get.find<AuthController>();
  final OrdersRepository ordersRepository = OrdersRepository();
  final UtilsServices utilsServices = UtilsServices();

  bool isLoading = false;

  void setLoading(bool value) {
    isLoading = value;
    update();
  }

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrdersResult<List<CartItemModel>> result =
        await ordersRepository.getOrderItems(
      orderId: order.id,
      token: authController.user.token!,
    );
    setLoading(false);
    result.when(
      success: (items) {
        order.items = items;
        update();
      },
      error: (message) {
        utilsServices.showCustomToast(
            message: message, isError: true, context: Get.context!);
      },
    );
  }
}
