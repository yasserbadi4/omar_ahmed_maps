import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omar_ahmed_maps/data/models/place.dart';
import 'package:omar_ahmed_maps/data/models/place_directions.dart';
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

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebServices.getPlaceLocation(placeId, sessionToken);
    return Place.fromJson(place);
  }

  Future<PlaceDirections> getDirections(
      LatLng origin, LatLng destination) async {
    final directions =
        await placesWebServices.getDirections(origin, destination);
    return PlaceDirections.fromJson(directions);
  }
}
