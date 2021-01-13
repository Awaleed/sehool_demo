// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'forgot_password_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ForgotPasswordStateTearOff {
  const _$ForgotPasswordStateTearOff();

// ignore: unused_element
  _EnterYourEmail enterYourEmail({String email}) {
    return _EnterYourEmail(
      email: email,
    );
  }

// ignore: unused_element
  _EnterNewPassword enterNewPassword({String email, int timeout}) {
    return _EnterNewPassword(
      email: email,
      timeout: timeout,
    );
  }

// ignore: unused_element
  _EnterYourEmailLoading enterYourEmailLoading({String email}) {
    return _EnterYourEmailLoading(
      email: email,
    );
  }

// ignore: unused_element
  _EnterNewPasswordLoading enterNewPasswordLoading({String email}) {
    return _EnterNewPasswordLoading(
      email: email,
    );
  }

// ignore: unused_element
  _Success success() {
    return const _Success();
  }

// ignore: unused_element
  _FailureOnEnterYourEmail failureOnEnterYourEmail({String message}) {
    return _FailureOnEnterYourEmail(
      message: message,
    );
  }

// ignore: unused_element
  _FailureOnNewPassword failureOnNewPassword(
      {String message, String email, int timeout}) {
    return _FailureOnNewPassword(
      message: message,
      email: email,
      timeout: timeout,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ForgotPasswordState = _$ForgotPasswordStateTearOff();

/// @nodoc
mixin _$ForgotPasswordState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $ForgotPasswordStateCopyWith<$Res> {
  factory $ForgotPasswordStateCopyWith(
          ForgotPasswordState value, $Res Function(ForgotPasswordState) then) =
      _$ForgotPasswordStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ForgotPasswordStateCopyWithImpl<$Res>
    implements $ForgotPasswordStateCopyWith<$Res> {
  _$ForgotPasswordStateCopyWithImpl(this._value, this._then);

  final ForgotPasswordState _value;
  // ignore: unused_field
  final $Res Function(ForgotPasswordState) _then;
}

/// @nodoc
abstract class _$EnterYourEmailCopyWith<$Res> {
  factory _$EnterYourEmailCopyWith(
          _EnterYourEmail value, $Res Function(_EnterYourEmail) then) =
      __$EnterYourEmailCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class __$EnterYourEmailCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$EnterYourEmailCopyWith<$Res> {
  __$EnterYourEmailCopyWithImpl(
      _EnterYourEmail _value, $Res Function(_EnterYourEmail) _then)
      : super(_value, (v) => _then(v as _EnterYourEmail));

  @override
  _EnterYourEmail get _value => super._value as _EnterYourEmail;

  @override
  $Res call({
    Object email = freezed,
  }) {
    return _then(_EnterYourEmail(
      email: email == freezed ? _value.email : email as String,
    ));
  }
}

/// @nodoc
class _$_EnterYourEmail implements _EnterYourEmail {
  const _$_EnterYourEmail({this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.enterYourEmail(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EnterYourEmail &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(email);

  @override
  _$EnterYourEmailCopyWith<_EnterYourEmail> get copyWith =>
      __$EnterYourEmailCopyWithImpl<_EnterYourEmail>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterYourEmail(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterYourEmail != null) {
      return enterYourEmail(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterYourEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterYourEmail != null) {
      return enterYourEmail(this);
    }
    return orElse();
  }
}

abstract class _EnterYourEmail implements ForgotPasswordState {
  const factory _EnterYourEmail({String email}) = _$_EnterYourEmail;

  String get email;
  _$EnterYourEmailCopyWith<_EnterYourEmail> get copyWith;
}

/// @nodoc
abstract class _$EnterNewPasswordCopyWith<$Res> {
  factory _$EnterNewPasswordCopyWith(
          _EnterNewPassword value, $Res Function(_EnterNewPassword) then) =
      __$EnterNewPasswordCopyWithImpl<$Res>;
  $Res call({String email, int timeout});
}

/// @nodoc
class __$EnterNewPasswordCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$EnterNewPasswordCopyWith<$Res> {
  __$EnterNewPasswordCopyWithImpl(
      _EnterNewPassword _value, $Res Function(_EnterNewPassword) _then)
      : super(_value, (v) => _then(v as _EnterNewPassword));

  @override
  _EnterNewPassword get _value => super._value as _EnterNewPassword;

  @override
  $Res call({
    Object email = freezed,
    Object timeout = freezed,
  }) {
    return _then(_EnterNewPassword(
      email: email == freezed ? _value.email : email as String,
      timeout: timeout == freezed ? _value.timeout : timeout as int,
    ));
  }
}

/// @nodoc
class _$_EnterNewPassword implements _EnterNewPassword {
  const _$_EnterNewPassword({this.email, this.timeout});

  @override
  final String email;
  @override
  final int timeout;

  @override
  String toString() {
    return 'ForgotPasswordState.enterNewPassword(email: $email, timeout: $timeout)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EnterNewPassword &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.timeout, timeout) ||
                const DeepCollectionEquality().equals(other.timeout, timeout)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(timeout);

  @override
  _$EnterNewPasswordCopyWith<_EnterNewPassword> get copyWith =>
      __$EnterNewPasswordCopyWithImpl<_EnterNewPassword>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterNewPassword(email, timeout);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterNewPassword != null) {
      return enterNewPassword(email, timeout);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterNewPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterNewPassword != null) {
      return enterNewPassword(this);
    }
    return orElse();
  }
}

abstract class _EnterNewPassword implements ForgotPasswordState {
  const factory _EnterNewPassword({String email, int timeout}) =
      _$_EnterNewPassword;

  String get email;
  int get timeout;
  _$EnterNewPasswordCopyWith<_EnterNewPassword> get copyWith;
}

/// @nodoc
abstract class _$EnterYourEmailLoadingCopyWith<$Res> {
  factory _$EnterYourEmailLoadingCopyWith(_EnterYourEmailLoading value,
          $Res Function(_EnterYourEmailLoading) then) =
      __$EnterYourEmailLoadingCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class __$EnterYourEmailLoadingCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$EnterYourEmailLoadingCopyWith<$Res> {
  __$EnterYourEmailLoadingCopyWithImpl(_EnterYourEmailLoading _value,
      $Res Function(_EnterYourEmailLoading) _then)
      : super(_value, (v) => _then(v as _EnterYourEmailLoading));

  @override
  _EnterYourEmailLoading get _value => super._value as _EnterYourEmailLoading;

  @override
  $Res call({
    Object email = freezed,
  }) {
    return _then(_EnterYourEmailLoading(
      email: email == freezed ? _value.email : email as String,
    ));
  }
}

/// @nodoc
class _$_EnterYourEmailLoading implements _EnterYourEmailLoading {
  const _$_EnterYourEmailLoading({this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.enterYourEmailLoading(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EnterYourEmailLoading &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(email);

  @override
  _$EnterYourEmailLoadingCopyWith<_EnterYourEmailLoading> get copyWith =>
      __$EnterYourEmailLoadingCopyWithImpl<_EnterYourEmailLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterYourEmailLoading(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterYourEmailLoading != null) {
      return enterYourEmailLoading(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterYourEmailLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterYourEmailLoading != null) {
      return enterYourEmailLoading(this);
    }
    return orElse();
  }
}

abstract class _EnterYourEmailLoading implements ForgotPasswordState {
  const factory _EnterYourEmailLoading({String email}) =
      _$_EnterYourEmailLoading;

  String get email;
  _$EnterYourEmailLoadingCopyWith<_EnterYourEmailLoading> get copyWith;
}

/// @nodoc
abstract class _$EnterNewPasswordLoadingCopyWith<$Res> {
  factory _$EnterNewPasswordLoadingCopyWith(_EnterNewPasswordLoading value,
          $Res Function(_EnterNewPasswordLoading) then) =
      __$EnterNewPasswordLoadingCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class __$EnterNewPasswordLoadingCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$EnterNewPasswordLoadingCopyWith<$Res> {
  __$EnterNewPasswordLoadingCopyWithImpl(_EnterNewPasswordLoading _value,
      $Res Function(_EnterNewPasswordLoading) _then)
      : super(_value, (v) => _then(v as _EnterNewPasswordLoading));

  @override
  _EnterNewPasswordLoading get _value =>
      super._value as _EnterNewPasswordLoading;

  @override
  $Res call({
    Object email = freezed,
  }) {
    return _then(_EnterNewPasswordLoading(
      email: email == freezed ? _value.email : email as String,
    ));
  }
}

/// @nodoc
class _$_EnterNewPasswordLoading implements _EnterNewPasswordLoading {
  const _$_EnterNewPasswordLoading({this.email});

  @override
  final String email;

  @override
  String toString() {
    return 'ForgotPasswordState.enterNewPasswordLoading(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _EnterNewPasswordLoading &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(email);

  @override
  _$EnterNewPasswordLoadingCopyWith<_EnterNewPasswordLoading> get copyWith =>
      __$EnterNewPasswordLoadingCopyWithImpl<_EnterNewPasswordLoading>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterNewPasswordLoading(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterNewPasswordLoading != null) {
      return enterNewPasswordLoading(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return enterNewPasswordLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (enterNewPasswordLoading != null) {
      return enterNewPasswordLoading(this);
    }
    return orElse();
  }
}

abstract class _EnterNewPasswordLoading implements ForgotPasswordState {
  const factory _EnterNewPasswordLoading({String email}) =
      _$_EnterNewPasswordLoading;

  String get email;
  _$EnterNewPasswordLoadingCopyWith<_EnterNewPasswordLoading> get copyWith;
}

/// @nodoc
abstract class _$SuccessCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) then) =
      __$SuccessCopyWithImpl<$Res>;
}

/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
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
    return 'ForgotPasswordState.success()';
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
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return success();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
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
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success implements ForgotPasswordState {
  const factory _Success() = _$_Success;
}

/// @nodoc
abstract class _$FailureOnEnterYourEmailCopyWith<$Res> {
  factory _$FailureOnEnterYourEmailCopyWith(_FailureOnEnterYourEmail value,
          $Res Function(_FailureOnEnterYourEmail) then) =
      __$FailureOnEnterYourEmailCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$FailureOnEnterYourEmailCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$FailureOnEnterYourEmailCopyWith<$Res> {
  __$FailureOnEnterYourEmailCopyWithImpl(_FailureOnEnterYourEmail _value,
      $Res Function(_FailureOnEnterYourEmail) _then)
      : super(_value, (v) => _then(v as _FailureOnEnterYourEmail));

  @override
  _FailureOnEnterYourEmail get _value =>
      super._value as _FailureOnEnterYourEmail;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(_FailureOnEnterYourEmail(
      message: message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$_FailureOnEnterYourEmail implements _FailureOnEnterYourEmail {
  const _$_FailureOnEnterYourEmail({this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'ForgotPasswordState.failureOnEnterYourEmail(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FailureOnEnterYourEmail &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @override
  _$FailureOnEnterYourEmailCopyWith<_FailureOnEnterYourEmail> get copyWith =>
      __$FailureOnEnterYourEmailCopyWithImpl<_FailureOnEnterYourEmail>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return failureOnEnterYourEmail(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failureOnEnterYourEmail != null) {
      return failureOnEnterYourEmail(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return failureOnEnterYourEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failureOnEnterYourEmail != null) {
      return failureOnEnterYourEmail(this);
    }
    return orElse();
  }
}

abstract class _FailureOnEnterYourEmail implements ForgotPasswordState {
  const factory _FailureOnEnterYourEmail({String message}) =
      _$_FailureOnEnterYourEmail;

  String get message;
  _$FailureOnEnterYourEmailCopyWith<_FailureOnEnterYourEmail> get copyWith;
}

/// @nodoc
abstract class _$FailureOnNewPasswordCopyWith<$Res> {
  factory _$FailureOnNewPasswordCopyWith(_FailureOnNewPassword value,
          $Res Function(_FailureOnNewPassword) then) =
      __$FailureOnNewPasswordCopyWithImpl<$Res>;
  $Res call({String message, String email, int timeout});
}

/// @nodoc
class __$FailureOnNewPasswordCopyWithImpl<$Res>
    extends _$ForgotPasswordStateCopyWithImpl<$Res>
    implements _$FailureOnNewPasswordCopyWith<$Res> {
  __$FailureOnNewPasswordCopyWithImpl(
      _FailureOnNewPassword _value, $Res Function(_FailureOnNewPassword) _then)
      : super(_value, (v) => _then(v as _FailureOnNewPassword));

  @override
  _FailureOnNewPassword get _value => super._value as _FailureOnNewPassword;

  @override
  $Res call({
    Object message = freezed,
    Object email = freezed,
    Object timeout = freezed,
  }) {
    return _then(_FailureOnNewPassword(
      message: message == freezed ? _value.message : message as String,
      email: email == freezed ? _value.email : email as String,
      timeout: timeout == freezed ? _value.timeout : timeout as int,
    ));
  }
}

/// @nodoc
class _$_FailureOnNewPassword implements _FailureOnNewPassword {
  const _$_FailureOnNewPassword({this.message, this.email, this.timeout});

  @override
  final String message;
  @override
  final String email;
  @override
  final int timeout;

  @override
  String toString() {
    return 'ForgotPasswordState.failureOnNewPassword(message: $message, email: $email, timeout: $timeout)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _FailureOnNewPassword &&
            (identical(other.message, message) ||
                const DeepCollectionEquality()
                    .equals(other.message, message)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.timeout, timeout) ||
                const DeepCollectionEquality().equals(other.timeout, timeout)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(timeout);

  @override
  _$FailureOnNewPasswordCopyWith<_FailureOnNewPassword> get copyWith =>
      __$FailureOnNewPasswordCopyWithImpl<_FailureOnNewPassword>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult enterYourEmail(String email),
    @required TResult enterNewPassword(String email, int timeout),
    @required TResult enterYourEmailLoading(String email),
    @required TResult enterNewPasswordLoading(String email),
    @required TResult success(),
    @required TResult failureOnEnterYourEmail(String message),
    @required
        TResult failureOnNewPassword(String message, String email, int timeout),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return failureOnNewPassword(message, email, timeout);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult enterYourEmail(String email),
    TResult enterNewPassword(String email, int timeout),
    TResult enterYourEmailLoading(String email),
    TResult enterNewPasswordLoading(String email),
    TResult success(),
    TResult failureOnEnterYourEmail(String message),
    TResult failureOnNewPassword(String message, String email, int timeout),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failureOnNewPassword != null) {
      return failureOnNewPassword(message, email, timeout);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult enterYourEmail(_EnterYourEmail value),
    @required TResult enterNewPassword(_EnterNewPassword value),
    @required TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    @required TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    @required TResult success(_Success value),
    @required TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    @required TResult failureOnNewPassword(_FailureOnNewPassword value),
  }) {
    assert(enterYourEmail != null);
    assert(enterNewPassword != null);
    assert(enterYourEmailLoading != null);
    assert(enterNewPasswordLoading != null);
    assert(success != null);
    assert(failureOnEnterYourEmail != null);
    assert(failureOnNewPassword != null);
    return failureOnNewPassword(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult enterYourEmail(_EnterYourEmail value),
    TResult enterNewPassword(_EnterNewPassword value),
    TResult enterYourEmailLoading(_EnterYourEmailLoading value),
    TResult enterNewPasswordLoading(_EnterNewPasswordLoading value),
    TResult success(_Success value),
    TResult failureOnEnterYourEmail(_FailureOnEnterYourEmail value),
    TResult failureOnNewPassword(_FailureOnNewPassword value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (failureOnNewPassword != null) {
      return failureOnNewPassword(this);
    }
    return orElse();
  }
}

abstract class _FailureOnNewPassword implements ForgotPasswordState {
  const factory _FailureOnNewPassword(
      {String message, String email, int timeout}) = _$_FailureOnNewPassword;

  String get message;
  String get email;
  int get timeout;
  _$FailureOnNewPasswordCopyWith<_FailureOnNewPassword> get copyWith;
}
