import 'package:omar_ahmed_maps/data/models/place_suggestions.dart';
import 'package:omar_ahmed_maps/data/web_services/places_web_services.dart';

class MapsRepository {
  final PlacesWebServices placesWebServices;

  MapsRepository(this.placesWebServices);

  Future<List<PlaceSuggestions>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebServices.fetchSuggestions(place, sessionToken);
    return suggestions
        .map((suggestion) => PlaceSuggestions.fromJson(suggestion))
        .toList();
  }
}
