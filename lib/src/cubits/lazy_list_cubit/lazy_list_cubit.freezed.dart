// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'lazy_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$LazyListStateTearOff {
  const _$LazyListStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _Loading loading() {
    return const _Loading();
  }

// ignore: unused_element
  _LoadingMore loadingMore(List<dynamic> values) {
    return _LoadingMore(
      values,
    );
  }

// ignore: unused_element
  _Success success(List<dynamic> values) {
    return _Success(
      values,
    );
  }

// ignore: unused_element
  _Finished finished(List<dynamic> values) {
    return _Finished(
      values,
    );
  }

// ignore: unused_element
  _Failure failure({String message}) {
    return _Failure(
      message: message,
    );
  }

// ignore: unused_element
  _FailureOnLoadMore failureOnLoadMore({String message, List<dynamic> values}) {
    return _FailureOnLoadMore(
      message: message,
      values: values,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $LazyListState = _$LazyListStateTearOff();

/// @nodoc
mixin _$LazyListState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $LazyListStateCopyWith<$Res> {
  factory $LazyListStateCopyWith(
          LazyListState value, $Res Function(LazyListState) then) =
      _$LazyListStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$LazyListStateCopyWithImpl<$Res>
    implements $LazyListStateCopyWith<$Res> {
  _$LazyListStateCopyWithImpl(this._value, this._then);

  final LazyListState _value;
  // ignore: unused_field
  final $Res Function(LazyListState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$LazyListStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc
class _$_Initial with DiagnosticableTreeMixin implements _Initial {
  const _$_Initial();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.initial()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'LazyListState.initial'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements LazyListState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$LazyListStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

/// @nodoc
class _$_Loading with DiagnosticableTreeMixin implements _Loading {
  const _$_Loading();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.loading()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties..add(DiagnosticsProperty('type', 'LazyListState.loading'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements LazyListState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$LoadingMoreCopyWith<$Res> {
  factory _$LoadingMoreCopyWith(
          _LoadingMore value, $Res Function(_LoadingMore) then) =
      __$LoadingMoreCopyWithImpl<$Res>;
  $Res call({List<dynamic> values});
}

/// @nodoc
class __$LoadingMoreCopyWithImpl<$Res> extends _$LazyListStateCopyWithImpl<$Res>
    implements _$LoadingMoreCopyWith<$Res> {
  __$LoadingMoreCopyWithImpl(
      _LoadingMore _value, $Res Function(_LoadingMore) _then)
      : super(_value, (v) => _then(v as _LoadingMore));

  @override
  _LoadingMore get _value => super._value as _LoadingMore;

  @override
  $Res call({
    Object values = freezed,
  }) {
    return _then(_LoadingMore(
      values == freezed ? _value.values : values as List<dynamic>,
    ));
  }
}

/// @nodoc
class _$_LoadingMore with DiagnosticableTreeMixin implements _LoadingMore {
  const _$_LoadingMore(this.values) : assert(values != null);

  @override
  final List<dynamic> values;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.loadingMore(values: $values)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LazyListState.loadingMore'))
      ..add(DiagnosticsProperty('values', values));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoadingMore &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(values);

  @override
  _$LoadingMoreCopyWith<_LoadingMore> get copyWith =>
      __$LoadingMoreCopyWithImpl<_LoadingMore>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return loadingMore(values);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadingMore != null) {
      return loadingMore(values);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _LoadingMore implements LazyListState {
  const factory _LoadingMore(List<dynamic> values) = _$_LoadingMore;

  List<dynamic> get values;
  _$LoadingMoreCopyWith<_LoadingMore> get copyWith;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
  $Res call({List<dynamic> values});
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> extends _$LazyListStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;

  @override
  $Res call({
    Object values = freezed,
  }) {
    return _then(_Success(
      values == freezed ? _value.values : values as List<dynamic>,
    ));
  }
}

/// @nodoc
class _$_Success with DiagnosticableTreeMixin implements _Success {
  const _$_Success(this.values) : assert(values != null);

  @override
  final List<dynamic> values;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.success(values: $values)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LazyListState.success'))
      ..add(DiagnosticsProperty('values', values));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Success &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(values);

  @override
  _$SuccessCopyWith<_Success> get copyWith =>
      __$SuccessCopyWithImpl<_Success>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return success(values);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(values);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements LazyListState {
  const factory _Success(List<dynamic> values) = _$_Success;

  List<dynamic> get values;
  _$SuccessCopyWith<_Success> get copyWith;
}

/// @nodoc
abstract class _$FinishedCopyWith<$Res> {
  factory _$FinishedCopyWith(_Finished value, $Res Function(_Finished) then) =
      __$FinishedCopyWithImpl<$Res>;
  $Res call({List<dynamic> values});
}

/// @nodoc
class __$FinishedCopyWithImpl<$Res> extends _$LazyListStateCopyWithImpl<$Res>
    implements _$FinishedCopyWith<$Res> {
  __$FinishedCopyWithImpl(_Finished _value, $Res Function(_Finished) _then)
      : super(_value, (v) => _then(v as _Finished));

  @override
  _Finished get _value => super._value as _Finished;

  @override
  $Res call({
    Object values = freezed,
  }) {
    return _then(_Finished(
      values == freezed ? _value.values : values as List<dynamic>,
    ));
  }
}

/// @nodoc
class _$_Finished with DiagnosticableTreeMixin implements _Finished {
  const _$_Finished(this.values) : assert(values != null);

  @override
  final List<dynamic> values;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.finished(values: $values)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LazyListState.finished'))
      ..add(DiagnosticsProperty('values', values));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Finished &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(values);

  @override
  _$FinishedCopyWith<_Finished> get copyWith =>
      __$FinishedCopyWithImpl<_Finished>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return finished(values);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (finished != null) {
      return finished(values);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return finished(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (finished != null) {
      return finished(this);
    }
    return orElse();
  }
}

abstract class _Finished implements LazyListState {
  const factory _Finished(List<dynamic> values) = _$_Finished;

  List<dynamic> get values;
  _$FinishedCopyWith<_Finished> get copyWith;
}

/// @nodoc
abstract class _$FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) then) =
      __$FailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$FailureCopyWithImpl<$Res> extends _$LazyListStateCopyWithImpl<$Res>
    implements _$FailureCopyWith<$Res> {
  __$FailureCopyWithImpl(_Failure _value, $Res Function(_Failure) _then)
      : super(_value, (v) => _then(v as _Failure));

  @override
  _Failure get _value => super._value as _Failure;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_Failure(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_Failure with DiagnosticableTreeMixin implements _Failure {
  const _$_Failure({this.message});

  @override
  final String message;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.failure(message: $message)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LazyListState.failure'))
      ..add(DiagnosticsProperty('message', message));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Failure &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$FailureCopyWith<_Failure> get copyWith =>
      __$FailureCopyWithImpl<_Failure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements LazyListState {
  const factory _Failure({String message}) = _$_Failure;

  String get message;
  _$FailureCopyWith<_Failure> get copyWith;
}

/// @nodoc
abstract class _$FailureOnLoadMoreCopyWith<$Res> {
  factory _$FailureOnLoadMoreCopyWith(
          _FailureOnLoadMore value, $Res Function(_FailureOnLoadMore) then) =
      __$FailureOnLoadMoreCopyWithImpl<$Res>;
  $Res call({String message, List<dynamic> values});
}

/// @nodoc
class __$FailureOnLoadMoreCopyWithImpl<$Res>
    extends _$LazyListStateCopyWithImpl<$Res>
    implements _$FailureOnLoadMoreCopyWith<$Res> {
  __$FailureOnLoadMoreCopyWithImpl(
      _FailureOnLoadMore _value, $Res Function(_FailureOnLoadMore) _then)
      : super(_value, (v) => _then(v as _FailureOnLoadMore));

  @override
  _FailureOnLoadMore get _value => super._value as _FailureOnLoadMore;

  @override
  $Res call({
    Object message = freezed,
    Object values = freezed,
  }) {
    return _then(_FailureOnLoadMore(
      message: message == freezed ? _value.message : message as String,
      values: values == freezed ? _value.values : values as List<dynamic>,
    ));
  }
}

/// @nodoc
class _$_FailureOnLoadMore
    with DiagnosticableTreeMixin
    implements _FailureOnLoadMore {
  const _$_FailureOnLoadMore({this.message, this.values});

  @override
  final String message;
  @override
  final List<dynamic> values;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LazyListState.failureOnLoadMore(message: $message, values: $values)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LazyListState.failureOnLoadMore'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('values', values));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FailureOnLoadMore &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.values, values) ||
                const DeepCollectionEquality().equals(other.values, values)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(values);

  @override
  _$FailureOnLoadMoreCopyWith<_FailureOnLoadMore> get copyWith =>
      __$FailureOnLoadMoreCopyWithImpl<_FailureOnLoadMore>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loadingMore(List<dynamic> values),
    @required TResult success(List<dynamic> values),
    @required TResult finished(List<dynamic> values),
    @required TResult failure(String message),
    @required TResult failureOnLoadMore(String message, List<dynamic> values),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return failureOnLoadMore(message, values);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loadingMore(List<dynamic> values),
    TResult success(List<dynamic> values),
    TResult finished(List<dynamic> values),
    TResult failure(String message),
    TResult failureOnLoadMore(String message, List<dynamic> values),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failureOnLoadMore != null) {
      return failureOnLoadMore(message, values);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult loadingMore(_LoadingMore value),
    @required TResult success(_Success value),
    @required TResult finished(_Finished value),
    @required TResult failure(_Failure value),
    @required TResult failureOnLoadMore(_FailureOnLoadMore value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loadingMore != null);
    assert(success != null);
    assert(finished != null);
    assert(failure != null);
    assert(failureOnLoadMore != null);
    return failureOnLoadMore(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult loadingMore(_LoadingMore value),
    TResult success(_Success value),
    TResult finished(_Finished value),
    TResult failure(_Failure value),
    TResult failureOnLoadMore(_FailureOnLoadMore value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failureOnLoadMore != null) {
      return failureOnLoadMore(this);
    }
    return orElse();
  }
}

abstract class _FailureOnLoadMore implements LazyListState {
  const factory _FailureOnLoadMore({String message, List<dynamic> values}) =
      _$_FailureOnLoadMore;

  String get message;
  List<dynamic> get values;
  _$FailureOnLoadMoreCopyWith<_FailureOnLoadMore> get copyWith;
}
