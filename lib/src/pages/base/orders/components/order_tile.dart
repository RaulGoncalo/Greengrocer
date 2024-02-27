import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/base/orders/components/order_status_widget.dart';
import 'package:quitanda/src/pages/base/orders/controller/order_controller.dart';
import 'package:quitanda/src/pages/common_widgets/payment_dialog.dart';
import 'package:quitanda/src/services/utils_services.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  OrderTile({required this.order, super.key});

  final UtilsServices _utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: GetBuilder<OrderController>(
            init: OrderController(order: order),
            //O global = false, faz com que cada card tera seu respectivo contralador, ajundando ele trabalhar de forma idependente dos demais
            //Exemplo: Desta forma ao abrir um card ele irá demonstrar o Loading apenas para ele. Se o global fosse true, ao abrir um card que não foi carregado os cards já abertos iram recarregar de novo.
            global: false,
            builder: (controller) {
              return ExpansionTile(
                initiallyExpanded: order.status == 'pending_payment',
                onExpansionChanged: (value) {
                  if (value && order.items.isEmpty) {
                    controller.getOrderItems();
                  }
                },
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pedido: ${order.id}'),
                    Text(
                      _utilsServices.formatDateTime(order.createdDateTime!),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                children: controller.isLoading
                    ? [
                        Container(
                          height: 80,
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(),
                        ),
                      ]
                    : [
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              //lista de produtos
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  height: 150,
                                  child: ListView(
                                    children:
                                        controller.order.items.map((orderItem) {
                                      return _OrderItemWidget(
                                        utilsServices: _utilsServices,
                                        orderItem: orderItem,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),

                              //Divisor
                              VerticalDivider(
                                color: Colors.grey.shade300,
                                thickness: 2,
                              ),

                              //Status do pedio
                              Expanded(
                                flex: 2,
                                child: OrderStatusWidget(
                                  status: order.status,
                                  isOverdue: order.overdueDateTime
                                      .isBefore(DateTime.now()),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Total
                        Text.rich(
                          TextSpan(
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              children: [
                                const TextSpan(
                                  text: 'Total ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: _utilsServices
                                      .priceToCurrency(order.total),
                                ),
                              ]),
                        ),

                        //Botão pagamento
                        Visibility(
                          visible: order.status == 'pending_payment' &&
                              !order.isOverDue,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return PaymentDialog(
                                      order: order,
                                    );
                                  });
                            },
                            icon: Image.asset(
                              'assets/app_images/pix.png',
                              height: 18,
                            ),
                            label: const Text(
                              'Ver QR code Pix',
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                          ),
                        ),
                      ],
              );
            },
          )),
    );
  }
}

class _OrderItemWidget extends StatelessWidget {
  const _OrderItemWidget({
    required this.orderItem,
    required this.utilsServices,
  });

  final UtilsServices utilsServices;
  final CartItemModel orderItem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Text(
            '${orderItem.quantity} ${orderItem.item.unit} ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(orderItem.item.name)),
          Text(utilsServices.priceToCurrency(orderItem.totalPrice()))
        ],
      ),
    );
  }
}
