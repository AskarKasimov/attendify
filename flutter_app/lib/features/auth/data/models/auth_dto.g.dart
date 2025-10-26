// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginRequestDtoImpl _$$LoginRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$LoginRequestDtoImpl(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$$LoginRequestDtoImplToJson(
  _$LoginRequestDtoImpl instance,
) => <String, dynamic>{'email': instance.email, 'password': instance.password};

_$RegisterRequestDtoImpl _$$RegisterRequestDtoImplFromJson(
  Map<String, dynamic> json,
) => _$RegisterRequestDtoImpl(
  email: json['email'] as String,
  password: json['password'] as String,
  name: json['name'] as String,
);

Map<String, dynamic> _$$RegisterRequestDtoImplToJson(
  _$RegisterRequestDtoImpl instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'name': instance.name,
};

_$AuthResponseDtoImpl _$$AuthResponseDtoImplFromJson(
  Map<String, dynamic> json,
) => _$AuthResponseDtoImpl(
  access_token: json['access_token'] as String,
  refresh_token: json['refresh_token'] as String,
  user: json['user'] as Map<String, dynamic>,
);

Map<String, dynamic> _$$AuthResponseDtoImplToJson(
  _$AuthResponseDtoImpl instance,
) => <String, dynamic>{
  'access_token': instance.access_token,
  'refresh_token': instance.refresh_token,
  'user': instance.user,
};
