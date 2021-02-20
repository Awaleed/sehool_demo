import 'package:json_annotation/json_annotation.dart';

part 'association_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  nullable: true,
)
class AssociationModel {
  const AssociationModel({
    this.association,
    this.discount,
  });

  final List<Association> association;
  final double discount;

  factory AssociationModel.fromJson(Map<String, dynamic> json) => _$AssociationModelFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationModelToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
  nullable: true,
)
class Association {
  const Association({
    this.id,
    this.name,
    this.associationOfficial,
    this.phoneOfficial,
    this.ownersName,
  });

  final int id;
  final String name;
  final String associationOfficial;
  final int phoneOfficial;
  final String ownersName;

  @override
  String toString() => name ?? '';

  factory Association.fromJson(Map<String, dynamic> json) => _$AssociationFromJson(json);
  Map<String, dynamic> toJson() => _$AssociationToJson(this);
}
