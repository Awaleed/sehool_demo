import 'package:json_annotation/json_annotation.dart';

part 'bank_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true, nullable: true)
class BankModel {
  const BankModel({
    this.name,
    this.accountNumber,
    this.ibanNumber,
    this.id,
  });

  final int id;
  final String name;
  final String accountNumber;
  final String ibanNumber;

  factory BankModel.fromJson(Map<String, dynamic> json) => _$BankModelFromJson(json);
  Map<String, dynamic> toJson() => _$BankModelToJson(this);
}
