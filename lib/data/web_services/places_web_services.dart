import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';

class PlacesWebServices {
  late Dio dio;

  PlacesWebServices() {
    BaseOptions options = BaseOptions(
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        suggestionsBaseURL,
        queryParameters: {
          "input": place,
          "types": "address",
          "components": "country:eg",
          "key": googleAPIkey,
          "sessiontoken": sessionToken,
        },
      );
      print(response.data['predictions']);
      print(response.statusCode);
      return await response.data["predictions"];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

// Places Method

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        placeLocationBaseUrl,
        queryParameters: {
          "place_id": placeId,
          "fields": "geometry",
          "key": googleAPIkey,
          "sessiontoken": sessionToken,
        },
      );
      return await response.data;
    } catch (error) {
      return Future.error("Place Location Error : ",
          StackTrace.fromString(("This is its trace")));
    }
  }

// Directions Method
// Origin = Current Location
// Destination = Searched for location
  Future<dynamic> getDirections(LatLng origin, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsBaseUrl,
        queryParameters: {
          "origin": '${origin.latitude}, ${origin.longitude}',
          "destination": '${destination.latitude}, ${destination.longitude}',
          "key": googleAPIkey,
        },
      );
      return await response.data;
    } catch (error) {
      return Future.error("Place Location Error : ",
          StackTrace.fromString(("This is its trace")));
    }
  }
}
