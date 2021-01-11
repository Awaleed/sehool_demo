import 'package:json_annotation/json_annotation.dart';

part 'dropdown_value_model.g.dart';

enum DropdownValueType {
  cites,
  citySections,
  slicingMethods,
  paymentMethods,
  addresses,
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  nullable: true,
)
class DropdownValueModel {
  final int id;
  final String name;
  final int image;

  const DropdownValueModel({
    this.id,
    this.name,
    this.image,
  });

  static String mapTypeToHint(DropdownValueType type) {
    switch (type) {
      default:
        throw UnsupportedError(
          'Unsupported DropdownValueType with type $type',
        );
    }
  }

  static String mapTypeToName(DropdownValueType type) {
    switch (type) {
      default:
        throw UnsupportedError(
          'Unsupported DropdownValueType with type $type',
        );
    }
  }

  factory DropdownValueModel.fromJson(Map<String, dynamic> json) =>
      _$DropdownValueModelFromJson(json);
  Map<String, dynamic> toJson() => _$DropdownValueModelToJson(this);

  @override
  String toString() => name;
}
