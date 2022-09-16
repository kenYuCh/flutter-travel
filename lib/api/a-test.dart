//

import 'package:dio/dio.dart';

// String url =
//     "https://tdx.transportdata.tw/api/basic/v2/Rail/TRA/LiveTrainDelay?$top=30&$format=JSON";

//
Dio dio = Dio(BaseOptions(
    // connectTimeout: 5000,
    // receiveTimeout: 5000,

    ));

class TestTravelAPI {
  TestTravelAPI() {
    init();
    getAuthorizationHeader();
  }
  init() async {}
  Future getAuthorizationHeader() async {
    final parameter = {
      "grant_type": "client_credentials",
      "client_id": "yuxainzh-d295a371-1746-4df0",
      "client_secret": "d5a8c700-6b95-4ca5-822b-5df531dda2e4"
    };
    String authUrl =
        "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token";
    final response = await dio.request(
      authUrl,
      data: parameter,
      onSendProgress: ((count, total) {
        print("${count}");
      }),
      onReceiveProgress: (count, total) {
        print("${count}");
      },
      options: Options(method: "POST", responseType: ResponseType.json),
    );
  }
}
