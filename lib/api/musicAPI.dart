import 'package:dio/dio.dart';

Map<dynamic, dynamic> options = {
  "method": 'GET',
  "url": 'https://shazam.p.rapidapi.com/search',
  "params": {"term": '醉赤壁', "locale": 'en-US', "offset": '0', "limit": '5'},
  "headers": {
    'X-RapidAPI-Key': '6f9e54ea3fmsh43442a822c0556dp114963jsn30c885a21cbb',
    'X-RapidAPI-Host': 'shazam.p.rapidapi.com'
  }
};

Dio dio = Dio(BaseOptions());

class MusicAPI {}
