import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quitanda/src/pages/base/orders/components/order_tile.dart';
import 'package:quitanda/src/pages/base/orders/controller/all_orders_controller.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos'),
      ),
      body: GetBuilder<AllOrdersController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllOrders(),
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              separatorBuilder: (_, index) => const SizedBox(height: 10),
              itemCount: controller.allOrders.length,
              itemBuilder: (_, index) {
                return OrderTile(order: controller.allOrders[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
