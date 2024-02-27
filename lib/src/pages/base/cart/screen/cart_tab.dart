import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/config/custom_colors.dart';
import 'package:quitanda/src/pages/base/cart/controller/cart_controller.dart';
import 'package:quitanda/src/pages/base/cart/screen/components/cart_tile.dart';
import 'package:quitanda/src/services/utils_services.dart';

class CartTab extends StatefulWidget {
  const CartTab({super.key});

  @override
  State<CartTab> createState() => _CartTabState();
}

class _CartTabState extends State<CartTab> {
  final UtilsServices utilsServices = UtilsServices();
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),
      body: Column(children: [
        Expanded(
          child: GetBuilder<CartController>(
            builder: (controller) {
              if (controller.cartItems.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.remove_shopping_cart,
                      color: CustomColors.customSwatchColor,
                      size: 40,
                    ),
                    const Text("Não há items no carrinho"),
                  ],
                );
              }

              return ListView.builder(
                itemCount: controller.cartItems.length,
                itemBuilder: (context, index) {
                  return CartTile(
                    cartItem: controller.cartItems[index],
                  );
                },
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 2)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Total geral",
                style: TextStyle(fontSize: 12),
              ),
              GetBuilder<CartController>(
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      utilsServices
                          .priceToCurrency(controller.cartTotalPrice()),
                      style: TextStyle(
                          fontSize: 24,
                          color: CustomColors.customSwatchColor,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50,
                child: GetBuilder<CartController>(
                  builder: (controller) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.customSwatchColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18))),
                        onPressed: controller.isCheckoutLoading ||
                                cartController.cartItems.isEmpty
                            ? null
                            : () async {
                                bool? result = await showOrderConfirmation();

                                if (result ?? false) {
                                  cartController.checkoutCart();
                                } else {
                                  // ignore: use_build_context_synchronously
                                  utilsServices.showCustomToast(
                                    context: context,
                                    message: 'Pedido não confirmado',
                                  );
                                }
                              },
                        child: controller.isCheckoutLoading
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Concluir pedido",
                                style: TextStyle(fontSize: 18),
                              ));
                  },
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }

  Future<bool?> showOrderConfirmation() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text("Confirmação"),
          content: const Text("Deseja realmente concluir o pedido?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Não"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Sim"),
            )
          ],
        );
      },
    );
  }
}
