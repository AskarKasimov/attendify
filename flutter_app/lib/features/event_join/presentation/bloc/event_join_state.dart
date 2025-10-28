import 'package:attendify/features/event_join/domain/entities/event_join_response.dart';

sealed class EventJoinState {
  const EventJoinState();

  String get pin;
  bool get isLoading => false;
  bool get canJoin => pin.length == 6 && !isLoading;
}

class EventJoinInitialState extends EventJoinState {
  const EventJoinInitialState({this.pin = ''});

  @override
  final String pin;
}

class EventJoinPinChangedState extends EventJoinState {
  const EventJoinPinChangedState({required this.pin});

  @override
  final String pin;
}

class EventJoinLoadingState extends EventJoinState {
  const EventJoinLoadingState({required this.pin});

  @override
  final String pin;

  @override
  bool get isLoading => true;
}

class EventJoinSuccessState extends EventJoinState {
  const EventJoinSuccessState({required this.pin, required this.response});

  @override
  final String pin;
  final EventJoinResponse response;
}

class EventJoinErrorState extends EventJoinState {
  const EventJoinErrorState({required this.pin, required this.message});

  @override
  final String pin;
  final String message;
}
