import 'drate.dart';

class CoinSocketDrateModel {
  List<ItemEntity>? list;

  CoinSocketDrateModel({this.list});

  factory CoinSocketDrateModel.fromJson(Map<String, dynamic> json) {
    return CoinSocketDrateModel(
      list:
          (json['DRATE'] as List<dynamic>?)
              ?.map((e) => ItemEntity.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'DRATE': list?.map((e) => e.toJson()).toList(),
  };
}
