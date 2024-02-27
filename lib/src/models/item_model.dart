// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  String id;
  @JsonKey(name: 'title')
  String name;
  @JsonKey(name: 'picture')
  String imgUrl;
  String unit;
  double price;
  String description;

  ItemModel({
    this.id = "",
    required this.name,
    required this.imgUrl,
    required this.unit,
    required this.price,
    required this.description,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  @override
  String toString() {
    return 'ItemModel(id: $id, name: $name, imgUrl: $imgUrl, unit: $unit, price: $price, description: $description)';
  }
}
