// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'checkout_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$CheckoutStateTearOff {
  const _$CheckoutStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _Loading loading() {
    return const _Loading();
  }

// ignore: unused_element
  _VisaPayment visaPayment(String payUrl, int orderId) {
    return _VisaPayment(
      payUrl,
      orderId,
    );
  }

// ignore: unused_element
  _Success success() {
    return const _Success();
  }

// ignore: unused_element
  _Failure failure({String message}) {
    return _Failure(
      message: message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $CheckoutState = _$CheckoutStateTearOff();

/// @nodoc
mixin _$CheckoutState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult visaPayment(String payUrl, int orderId),
    @required TResult success(),
    @required TResult failure(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult visaPayment(String payUrl, int orderId),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult visaPayment(_VisaPayment value),
    @required TResult success(_Success value),
    @required TResult failure(_Failure value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult visaPayment(_VisaPayment value),
    TResult success(_Success value),
    TResult failure(_Failure value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $CheckoutStateCopyWith<$Res> {
  factory $CheckoutStateCopyWith(
          CheckoutState value, $Res Function(CheckoutState) then) =
      _$CheckoutStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._value, this._then);

  final CheckoutState _value;
  // ignore: unused_field
  final $Res Function(CheckoutState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$CheckoutStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc
class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'CheckoutState.initial()';
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
    @required TResult visaPayment(String payUrl, int orderId),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult visaPayment(String payUrl, int orderId),
    TResult success(),
    TResult failure(String message),
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
    @required TResult visaPayment(_VisaPayment value),
    @required TResult success(_Success value),
    @required TResult failure(_Failure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult visaPayment(_VisaPayment value),
    TResult success(_Success value),
    TResult failure(_Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements CheckoutState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$LoadingCopyWith<$Res> {
  factory _$LoadingCopyWith(_Loading value, $Res Function(_Loading) then) =
      __$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<$Res> extends _$CheckoutStateCopyWithImpl<$Res>
    implements _$LoadingCopyWith<$Res> {
  __$LoadingCopyWithImpl(_Loading _value, $Res Function(_Loading) _then)
      : super(_value, (v) => _then(v as _Loading));

  @override
  _Loading get _value => super._value as _Loading;
}

/// @nodoc
class _$_Loading implements _Loading {
  const _$_Loading();

  @override
  String toString() {
    return 'CheckoutState.loading()';
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
    @required TResult visaPayment(String payUrl, int orderId),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult visaPayment(String payUrl, int orderId),
    TResult success(),
    TResult failure(String message),
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
    @required TResult visaPayment(_VisaPayment value),
    @required TResult success(_Success value),
    @required TResult failure(_Failure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult visaPayment(_VisaPayment value),
    TResult success(_Success value),
    TResult failure(_Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements CheckoutState {
  const factory _Loading() = _$_Loading;
}

/// @nodoc
abstract class _$VisaPaymentCopyWith<$Res> {
  factory _$VisaPaymentCopyWith(
          _VisaPayment value, $Res Function(_VisaPayment) then) =
      __$VisaPaymentCopyWithImpl<$Res>;
  $Res call({String payUrl, int orderId});
}

/// @nodoc
class __$VisaPaymentCopyWithImpl<$Res> extends _$CheckoutStateCopyWithImpl<$Res>
    implements _$VisaPaymentCopyWith<$Res> {
  __$VisaPaymentCopyWithImpl(
      _VisaPayment _value, $Res Function(_VisaPayment) _then)
      : super(_value, (v) => _then(v as _VisaPayment));

  @override
  _VisaPayment get _value => super._value as _VisaPayment;

  @override
  $Res call({
    Object payUrl = freezed,
    Object orderId = freezed,
  }) {
    return _then(_VisaPayment(
      payUrl == freezed ? _value.payUrl : payUrl as String,
      orderId == freezed ? _value.orderId : orderId as int,
    ));
  }
}

/// @nodoc
class _$_VisaPayment implements _VisaPayment {
  const _$_VisaPayment(this.payUrl, this.orderId)
      : assert(payUrl != null),
        assert(orderId != null);

  @override
  final String payUrl;
  @override
  final int orderId;

  @override
  String toString() {
    return 'CheckoutState.visaPayment(payUrl: $payUrl, orderId: $orderId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _VisaPayment &&
            (identical(other.payUrl, payUrl) ||
                const DeepCollectionEquality().equals(other.payUrl, payUrl)) &&
            (identical(other.orderId, orderId) ||
                const DeepCollectionEquality().equals(other.orderId, orderId)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(payUrl) ^
      const DeepCollectionEquality().hash(orderId);

  @JsonKey(ignore: true)
  @override
  _$VisaPaymentCopyWith<_VisaPayment> get copyWith =>
      __$VisaPaymentCopyWithImpl<_VisaPayment>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult visaPayment(String payUrl, int orderId),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return visaPayment(payUrl, orderId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult visaPayment(String payUrl, int orderId),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (visaPayment != null) {
      return visaPayment(payUrl, orderId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult visaPayment(_VisaPayment value),
    @required TResult success(_Success value),
    @required TResult failure(_Failure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return visaPayment(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult visaPayment(_VisaPayment value),
    TResult success(_Success value),
    TResult failure(_Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (visaPayment != null) {
      return visaPayment(this);
    }
    return orElse();
  }
}

abstract class _VisaPayment implements CheckoutState {
  const factory _VisaPayment(String payUrl, int orderId) = _$_VisaPayment;

  String get payUrl;
  int get orderId;
  @JsonKey(ignore: true)
  _$VisaPaymentCopyWith<_VisaPayment> get copyWith;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res> extends _$CheckoutStateCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(_Success _value, $Res Function(_Success) _then)
      : super(_value, (v) => _then(v as _Success));

  @override
  _Success get _value => super._value as _Success;
}

/// @nodoc
class _$_Success implements _Success {
  const _$_Success();

  @override
  String toString() {
    return 'CheckoutState.success()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Success);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult visaPayment(String payUrl, int orderId),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return success();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult visaPayment(String payUrl, int orderId),
    TResult success(),
    TResult failure(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(_Initial value),
    @required TResult loading(_Loading value),
    @required TResult visaPayment(_VisaPayment value),
    @required TResult success(_Success value),
    @required TResult failure(_Failure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult visaPayment(_VisaPayment value),
    TResult success(_Success value),
    TResult failure(_Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements CheckoutState {
  const factory _Success() = _$_Success;
}

/// @nodoc
abstract class _$FailureCopyWith<$Res> {
  factory _$FailureCopyWith(_Failure value, $Res Function(_Failure) then) =
      __$FailureCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$FailureCopyWithImpl<$Res> extends _$CheckoutStateCopyWithImpl<$Res>
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
class _$_Failure implements _Failure {
  const _$_Failure({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'CheckoutState.failure(message: $message)';
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

  @JsonKey(ignore: true)
  @override
  _$FailureCopyWith<_Failure> get copyWith =>
      __$FailureCopyWithImpl<_Failure>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult visaPayment(String payUrl, int orderId),
    @required TResult success(),
    @required TResult failure(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult visaPayment(String payUrl, int orderId),
    TResult success(),
    TResult failure(String message),
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
    @required TResult visaPayment(_VisaPayment value),
    @required TResult success(_Success value),
    @required TResult failure(_Failure value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(visaPayment != null);
    assert(success != null);
    assert(failure != null);
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(_Initial value),
    TResult loading(_Loading value),
    TResult visaPayment(_VisaPayment value),
    TResult success(_Success value),
    TResult failure(_Failure value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure implements CheckoutState {
  const factory _Failure({String message}) = _$_Failure;

  String get message;
  @JsonKey(ignore: true)
  _$FailureCopyWith<_Failure> get copyWith;
}
