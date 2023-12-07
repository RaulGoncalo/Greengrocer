import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/models/user_model.dart';

ItemModel apple = ItemModel(
    name: "Maçã",
    imgUrl: 'assets/fruits/apple.png',
    unit: "Kg",
    price: 5.5,
    description:
        "Uma fruta tipicamente conhecida no mundo, geralmente da em maçeiras");

ItemModel grape = ItemModel(
    name: "Uva",
    imgUrl: 'assets/fruits/grape.png',
    unit: "Kg",
    price: 7.4,
    description: "A melhor uva da reigião");

ItemModel guava = ItemModel(
    name: "Goiaba",
    imgUrl: 'assets/fruits/guava.png',
    unit: "Kg",
    price: 11.3,
    description: "A melhor goiaba da reigião");

ItemModel kiwi = ItemModel(
    name: "Kiwi",
    imgUrl: 'assets/fruits/kiwi.png',
    unit: "un",
    price: 2.5,
    description: "O melhor kiwi da reigião");

ItemModel mango = ItemModel(
    name: "Manga",
    imgUrl: 'assets/fruits/mango.png',
    unit: "un",
    price: 2.5,
    description: "A melhor manga da reigião");

ItemModel papaya = ItemModel(
    name: "Mamão Papaya",
    imgUrl: 'assets/fruits/papaya.png',
    unit: "kg",
    price: 8,
    description: "O melhor mamão papaya da reigião");

List<ItemModel> items = [apple, grape, guava, kiwi, mango, papaya];

List<String> categories = [
  'Frutas',
  'Legumes',
  'Lacteos',
  'Carnes',
  'Cereais',
  'Verduras'
];

List<CartItemModel> cartItems = [
  CartItemModel(item: apple, quantity: 2),
  CartItemModel(item: mango, quantity: 1),
  CartItemModel(item: guava, quantity: 3),
];

UserModel user = UserModel(
    name: "Raul Silva",
    email: "raulsilva@gmail.com",
    phone: "16997108445",
    cpf: "46494728812",
    password: "");

List<OrderModel> orders = [
  OrderModel(
    id: 'asd45645d4sf',
    createdDateTime: DateTime.parse('2023-11-19 18:00:10.458'),
    overdueDateTime: DateTime.parse('2023-11-19 19:00:10.458'),
    items: [
      CartItemModel(item: apple, quantity: 2),
      CartItemModel(item: mango, quantity: 2),
    ],
    status: "pending_payment",
    copyAndPaste: 'poi1546sjk54',
    total: 11.0,
  ),
  OrderModel(
    id: 'D54FD87RE4SD5F52',
    createdDateTime: DateTime.parse('2023-11-19 18:00:10.458'),
    overdueDateTime: DateTime.parse('2023-11-19 19:00:10.458'),
    items: [
      CartItemModel(item: mango, quantity: 2),
    ],
    status: "delivered",
    copyAndPaste: '6s5d4f5464',
    total: 2.5,
  )
];
