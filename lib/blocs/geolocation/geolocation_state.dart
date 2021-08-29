part of 'geolocation_bloc.dart';

abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object> get props => [];
}

class GeolocationInitial extends GeolocationState {}

class GeolocationInitiated extends GeolocationState {
  final Position position;

  GeolocationInitiated({required this.position});

  @override
  List<Object> get props => [position];
}

class GeolocationError extends GeolocationState {}
