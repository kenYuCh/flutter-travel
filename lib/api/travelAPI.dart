import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:myapp20220914/model/travelModel.dart';

Dio dio = Dio(
  BaseOptions(
    connectTimeout: 50000,
    receiveTimeout: 50000,
  ),
);
// TDX API scret
final parameter = {
  "grant_type": "client_credentials",
  "client_id": "yuxainzh-d295a371-1746-4df0",
  "client_secret": "d5a8c700-6b95-4ca5-822b-5df531dda2e4"
};
String accessTtoken = "";

class TravelAPI {
  // get TDX-Token
  String authUrl =
      "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token";
  // API Url
  String allCity =
      "https://tdx.transportdata.tw/api/basic/v2/Tourism/ScenicSpot?%24top=30&%24format=JSON";

  List<TravelModel> result = [];
  // get info from API Data
  Future<List<TravelModel>> getAllCityData(String query) async {
    String theCity =
        "https://tdx.transportdata.tw/api/basic/v2/Tourism/ScenicSpot/${query}?%24format=JSON";
    // print(accessTtoken);
    Response response = await dio.get(theCity,
        options: Options(headers: {"authorization": "Bearer ${accessTtoken}"}));
    final jsonString = jsonEncode(response.data);
    final jsonArray = jsonDecode(jsonString) as List;
    result = jsonArray.map((e) => TravelModel.fromJson(e)).toList();
    return result;
  }

  // get Auth-accessTtoken from TDX authURL
  Future<void> getAuth() async {
    print("Auth.");
    try {
      Response response = await dio.post(
        authUrl,
        data: parameter,
        options: Options(
          headers: {
            "content-type": "application/x-www-form-urlencoded",
          },
        ),
      );
      // will response data that assign to accessToken-variable
      accessTtoken = response.data['access_token'];
    } on DioError catch (e) {
      print(e);
    }
  }
}
