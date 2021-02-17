// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BankModel _$BankModelFromJson(Map<String, dynamic> json) {
  return BankModel(
    name: json['name'] as String,
    accountNumber: json['account_number'] as String,
    ibanNumber: json['iban_number'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$BankModelToJson(BankModel instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'account_number': instance.accountNumber,
      'iban_number': instance.ibanNumber,
    };
