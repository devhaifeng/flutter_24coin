import 'drate.dart';

class CoinSocketHotModel {
  List<ItemEntity>? drate;

  CoinSocketHotModel({this.drate});

  factory CoinSocketHotModel.fromJson(Map<String, dynamic> json) {
    return CoinSocketHotModel(
      drate:
          (json['HOT'] as List<dynamic>?)
              ?.map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'HOT': drate?.map((e) => e.toJson()).toList(),
  };
}
