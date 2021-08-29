import 'package:geolocator/geolocator.dart';

abstract class BaseGeolocationRepo {
  Future<Position?> getCurrentLocation() async {}
}
