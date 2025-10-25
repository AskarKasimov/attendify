// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_value_objects.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Email {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EmailCopyWith<Email> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailCopyWith<$Res> {
  factory $EmailCopyWith(Email value, $Res Function(Email) then) =
      _$EmailCopyWithImpl<$Res, Email>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$EmailCopyWithImpl<$Res, $Val extends Email>
    implements $EmailCopyWith<$Res> {
  _$EmailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$EmailImplCopyWith<$Res> implements $EmailCopyWith<$Res> {
  factory _$$EmailImplCopyWith(
    _$EmailImpl value,
    $Res Function(_$EmailImpl) then,
  ) = __$$EmailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$EmailImplCopyWithImpl<$Res>
    extends _$EmailCopyWithImpl<$Res, _$EmailImpl>
    implements _$$EmailImplCopyWith<$Res> {
  __$$EmailImplCopyWithImpl(
    _$EmailImpl _value,
    $Res Function(_$EmailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$EmailImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EmailImpl extends _Email {
  const _$EmailImpl({required this.value}) : super._();

  @override
  final String value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailImplCopyWith<_$EmailImpl> get copyWith =>
      __$$EmailImplCopyWithImpl<_$EmailImpl>(this, _$identity);
}

abstract class _Email extends Email {
  const factory _Email({required final String value}) = _$EmailImpl;
  const _Email._() : super._();

  @override
  String get value;

  /// Create a copy of Email
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmailImplCopyWith<_$EmailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$Password {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of Password
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PasswordCopyWith<Password> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PasswordCopyWith<$Res> {
  factory $PasswordCopyWith(Password value, $Res Function(Password) then) =
      _$PasswordCopyWithImpl<$Res, Password>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$PasswordCopyWithImpl<$Res, $Val extends Password>
    implements $PasswordCopyWith<$Res> {
  _$PasswordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Password
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PasswordImplCopyWith<$Res>
    implements $PasswordCopyWith<$Res> {
  factory _$$PasswordImplCopyWith(
    _$PasswordImpl value,
    $Res Function(_$PasswordImpl) then,
  ) = __$$PasswordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$PasswordImplCopyWithImpl<$Res>
    extends _$PasswordCopyWithImpl<$Res, _$PasswordImpl>
    implements _$$PasswordImplCopyWith<$Res> {
  __$$PasswordImplCopyWithImpl(
    _$PasswordImpl _value,
    $Res Function(_$PasswordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Password
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$PasswordImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PasswordImpl extends _Password {
  const _$PasswordImpl({required this.value}) : super._();

  @override
  final String value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of Password
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordImplCopyWith<_$PasswordImpl> get copyWith =>
      __$$PasswordImplCopyWithImpl<_$PasswordImpl>(this, _$identity);
}

abstract class _Password extends Password {
  const factory _Password({required final String value}) = _$PasswordImpl;
  const _Password._() : super._();

  @override
  String get value;

  /// Create a copy of Password
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordImplCopyWith<_$PasswordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserName {
  String get value => throw _privateConstructorUsedError;

  /// Create a copy of UserName
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserNameCopyWith<UserName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserNameCopyWith<$Res> {
  factory $UserNameCopyWith(UserName value, $Res Function(UserName) then) =
      _$UserNameCopyWithImpl<$Res, UserName>;
  @useResult
  $Res call({String value});
}

/// @nodoc
class _$UserNameCopyWithImpl<$Res, $Val extends UserName>
    implements $UserNameCopyWith<$Res> {
  _$UserNameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserName
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _value.copyWith(
            value: null == value
                ? _value.value
                : value // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserNameImplCopyWith<$Res>
    implements $UserNameCopyWith<$Res> {
  factory _$$UserNameImplCopyWith(
    _$UserNameImpl value,
    $Res Function(_$UserNameImpl) then,
  ) = __$$UserNameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String value});
}

/// @nodoc
class __$$UserNameImplCopyWithImpl<$Res>
    extends _$UserNameCopyWithImpl<$Res, _$UserNameImpl>
    implements _$$UserNameImplCopyWith<$Res> {
  __$$UserNameImplCopyWithImpl(
    _$UserNameImpl _value,
    $Res Function(_$UserNameImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserName
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? value = null}) {
    return _then(
      _$UserNameImpl(
        value: null == value
            ? _value.value
            : value // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$UserNameImpl extends _UserName {
  const _$UserNameImpl({required this.value}) : super._();

  @override
  final String value;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserNameImpl &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  /// Create a copy of UserName
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserNameImplCopyWith<_$UserNameImpl> get copyWith =>
      __$$UserNameImplCopyWithImpl<_$UserNameImpl>(this, _$identity);
}

abstract class _UserName extends UserName {
  const factory _UserName({required final String value}) = _$UserNameImpl;
  const _UserName._() : super._();

  @override
  String get value;

  /// Create a copy of UserName
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserNameImplCopyWith<_$UserNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
