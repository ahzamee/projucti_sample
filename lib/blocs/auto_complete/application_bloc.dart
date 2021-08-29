import 'package:flutter/foundation.dart';
import 'package:projucti_sample/model/place_search.dart';
import 'package:projucti_sample/services/places_service.dart';

class ApplicationBloc with ChangeNotifier {
  final placesService = PlacesService();

  late List<PlaceSearch> searchResults;

  ApplicationBloc() {
    searchResults = [];
  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
