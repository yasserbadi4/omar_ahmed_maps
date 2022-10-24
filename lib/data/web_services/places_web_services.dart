import 'package:dio/dio.dart';
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
          "components": "coutry:eg",
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
}
