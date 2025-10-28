// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ble_device.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$BleDevice {
  /// Уникальный идентификатор устройства
  String get id => throw _privateConstructorUsedError;

  /// Название устройства (может быть пустым)
  String get name => throw _privateConstructorUsedError;

  /// Сила сигнала (Received Signal Strength Indicator)
  int get rssi => throw _privateConstructorUsedError;

  /// Список UUID сервисов, которые рекламирует устройство
  List<String> get serviceUuids => throw _privateConstructorUsedError;

  /// Дополнительные данные рекламы
  Map<String, dynamic> get advertisementData =>
      throw _privateConstructorUsedError;

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BleDeviceCopyWith<BleDevice> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BleDeviceCopyWith<$Res> {
  factory $BleDeviceCopyWith(BleDevice value, $Res Function(BleDevice) then) =
      _$BleDeviceCopyWithImpl<$Res, BleDevice>;
  @useResult
  $Res call({
    String id,
    String name,
    int rssi,
    List<String> serviceUuids,
    Map<String, dynamic> advertisementData,
  });
}

/// @nodoc
class _$BleDeviceCopyWithImpl<$Res, $Val extends BleDevice>
    implements $BleDeviceCopyWith<$Res> {
  _$BleDeviceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rssi = null,
    Object? serviceUuids = null,
    Object? advertisementData = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            rssi: null == rssi
                ? _value.rssi
                : rssi // ignore: cast_nullable_to_non_nullable
                      as int,
            serviceUuids: null == serviceUuids
                ? _value.serviceUuids
                : serviceUuids // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            advertisementData: null == advertisementData
                ? _value.advertisementData
                : advertisementData // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BleDeviceImplCopyWith<$Res>
    implements $BleDeviceCopyWith<$Res> {
  factory _$$BleDeviceImplCopyWith(
    _$BleDeviceImpl value,
    $Res Function(_$BleDeviceImpl) then,
  ) = __$$BleDeviceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int rssi,
    List<String> serviceUuids,
    Map<String, dynamic> advertisementData,
  });
}

/// @nodoc
class __$$BleDeviceImplCopyWithImpl<$Res>
    extends _$BleDeviceCopyWithImpl<$Res, _$BleDeviceImpl>
    implements _$$BleDeviceImplCopyWith<$Res> {
  __$$BleDeviceImplCopyWithImpl(
    _$BleDeviceImpl _value,
    $Res Function(_$BleDeviceImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? rssi = null,
    Object? serviceUuids = null,
    Object? advertisementData = null,
  }) {
    return _then(
      _$BleDeviceImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        rssi: null == rssi
            ? _value.rssi
            : rssi // ignore: cast_nullable_to_non_nullable
                  as int,
        serviceUuids: null == serviceUuids
            ? _value._serviceUuids
            : serviceUuids // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        advertisementData: null == advertisementData
            ? _value._advertisementData
            : advertisementData // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$BleDeviceImpl extends _BleDevice {
  const _$BleDeviceImpl({
    required this.id,
    required this.name,
    required this.rssi,
    required final List<String> serviceUuids,
    required final Map<String, dynamic> advertisementData,
  }) : _serviceUuids = serviceUuids,
       _advertisementData = advertisementData,
       super._();

  /// Уникальный идентификатор устройства
  @override
  final String id;

  /// Название устройства (может быть пустым)
  @override
  final String name;

  /// Сила сигнала (Received Signal Strength Indicator)
  @override
  final int rssi;

  /// Список UUID сервисов, которые рекламирует устройство
  final List<String> _serviceUuids;

  /// Список UUID сервисов, которые рекламирует устройство
  @override
  List<String> get serviceUuids {
    if (_serviceUuids is EqualUnmodifiableListView) return _serviceUuids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_serviceUuids);
  }

  /// Дополнительные данные рекламы
  final Map<String, dynamic> _advertisementData;

  /// Дополнительные данные рекламы
  @override
  Map<String, dynamic> get advertisementData {
    if (_advertisementData is EqualUnmodifiableMapView)
      return _advertisementData;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_advertisementData);
  }

  @override
  String toString() {
    return 'BleDevice(id: $id, name: $name, rssi: $rssi, serviceUuids: $serviceUuids, advertisementData: $advertisementData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BleDeviceImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.rssi, rssi) || other.rssi == rssi) &&
            const DeepCollectionEquality().equals(
              other._serviceUuids,
              _serviceUuids,
            ) &&
            const DeepCollectionEquality().equals(
              other._advertisementData,
              _advertisementData,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    rssi,
    const DeepCollectionEquality().hash(_serviceUuids),
    const DeepCollectionEquality().hash(_advertisementData),
  );

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BleDeviceImplCopyWith<_$BleDeviceImpl> get copyWith =>
      __$$BleDeviceImplCopyWithImpl<_$BleDeviceImpl>(this, _$identity);
}

abstract class _BleDevice extends BleDevice {
  const factory _BleDevice({
    required final String id,
    required final String name,
    required final int rssi,
    required final List<String> serviceUuids,
    required final Map<String, dynamic> advertisementData,
  }) = _$BleDeviceImpl;
  const _BleDevice._() : super._();

  /// Уникальный идентификатор устройства
  @override
  String get id;

  /// Название устройства (может быть пустым)
  @override
  String get name;

  /// Сила сигнала (Received Signal Strength Indicator)
  @override
  int get rssi;

  /// Список UUID сервисов, которые рекламирует устройство
  @override
  List<String> get serviceUuids;

  /// Дополнительные данные рекламы
  @override
  Map<String, dynamic> get advertisementData;

  /// Create a copy of BleDevice
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BleDeviceImplCopyWith<_$BleDeviceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
