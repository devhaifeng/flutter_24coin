import 'drate.dart';

class CoinSocketIrateModel {
  List<ItemEntity>? drate;

  CoinSocketIrateModel({this.drate});

  factory CoinSocketIrateModel.fromJson(Map<String, dynamic> json) {
    return CoinSocketIrateModel(
      drate:
          (json['IRATE'] as List<dynamic>?)
              ?.map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'IRATE': drate?.map((e) => e.toJson()).toList(),
  };
}
