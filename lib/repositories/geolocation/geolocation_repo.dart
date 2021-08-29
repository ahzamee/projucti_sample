import 'package:geolocator/geolocator.dart';
import 'package:projucti_sample/repositories/geolocation/base_geolocation_repo.dart';

class GeolocationRepo extends BaseGeolocationRepo {
  GeolocationRepo();

  @override
  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}
