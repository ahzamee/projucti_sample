import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projucti_sample/repositories/geolocation/geolocation_repo.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepo _geolocationRepo;
  StreamSubscription? _geolocationSubscription;
  GeolocationBloc({required GeolocationRepo geolocationRepo})
      : _geolocationRepo = geolocationRepo,
        super(GeolocationInitial());

  @override
  Stream<GeolocationState> mapEventToState(
    GeolocationEvent event,
  ) async* {
    if (event is LoadGeolocation) {
      yield* _mapLoadGeoLocationToState();
    } else if (event is UpdateGeolocation) {
      yield* _mapUpdateGeoLocationToState(event);
    }
  }

  Stream<GeolocationState> _mapLoadGeoLocationToState() async* {
    _geolocationSubscription?.cancel();
    final Position position = await _geolocationRepo.getCurrentLocation();

    add(UpdateGeolocation(position: position));
  }

  Stream<GeolocationState> _mapUpdateGeoLocationToState(
      UpdateGeolocation event) async* {
    yield GeolocationInitiated(position: event.position);
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
