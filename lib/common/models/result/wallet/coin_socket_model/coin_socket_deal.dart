import 'drate.dart';

class CoinSocketDealModel {
  List<ItemEntity>? drate;

  CoinSocketDealModel({this.drate});

  factory CoinSocketDealModel.fromJson(Map<String, dynamic> json) {
    return CoinSocketDealModel(
      drate:
          (json['DEAL'] as List<dynamic>?)
              ?.map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'DEAL': drate?.map((e) => e.toJson()).toList(),
  };
}
