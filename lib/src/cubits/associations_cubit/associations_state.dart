part of 'associations_cubit.dart';

@freezed
abstract class AssociationsState with _$AssociationsState {
  const factory AssociationsState.initial() = _Initial;
  const factory AssociationsState.loading() = _Loading;
  const factory AssociationsState.success(AssociationModel value) = _Success;
  const factory AssociationsState.failure({String message}) = _Failure;
}
