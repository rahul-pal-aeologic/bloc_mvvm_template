// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoginStateImpl _$$LoginStateImplFromJson(Map<String, dynamic> json) =>
    _$LoginStateImpl(
      loadingState:
          $enumDecodeNullable(_$LoadingStateEnumMap, json['loadingState']) ??
              LoadingState.idle,
      errorMessage: json['errorMessage'] as String?,
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$$LoginStateImplToJson(_$LoginStateImpl instance) =>
    <String, dynamic>{
      'loadingState': _$LoadingStateEnumMap[instance.loadingState]!,
      'errorMessage': instance.errorMessage,
      'userId': instance.userId,
    };

const _$LoadingStateEnumMap = {
  LoadingState.idle: 'idle',
  LoadingState.loading: 'loading',
  LoadingState.loaded: 'loaded',
  LoadingState.error: 'error',
};
