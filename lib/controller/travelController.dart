import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:myapp20220914/api/travelAPI.dart';

import 'package:myapp20220914/model/travelModel.dart';

class TravelController with ChangeNotifier, DiagnosticableTreeMixin {
  List<TravelModel> _travelList = [];
  List<TravelModel> get travelList => _travelList;
  List<TravelModel> _travelFavorite = [];
  List<TravelModel> get travelFavorite => _travelFavorite;
  List<TravelModel> _travelSearchResult = [];
  List<TravelModel> get travelSearchResult => _travelSearchResult;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool _isTop = true;
  bool get isTop => _isTop;
  final queryParameter = {"searchId": "Taipei", "count": 1000};
  TravelController() {
    init();
  }
  // initState
  Future<void> init() async {
    print("init...");
    await TravelAPI().getAuth();
    _travelList = await TravelAPI().getAllCityData("Taipei");
    print("取得資料筆數：${jsonEncode(_travelList[0]).length}");
    _travelSearchResult = _travelList;
    notifyListeners();
  }

  Future<void> getTravelData() async {
    print("getTravelData...");
    _travelList = await TravelAPI().getAllCityData("Taipei");
    notifyListeners();
  }

  void setAdd(TravelModel catalogs) {
    print("setAdd...");

    final result = travelFavorite.where((items) {
      final travelID = items.scenicSpotId.toString();
      final input = catalogs.scenicSpotId.toString();
      return travelID.contains(input);
    }).toList();
    print(result.length);

    // 若沒有找到資料就會加入此catalog
    result.isEmpty == true ? _travelFavorite.add(catalogs) : null;
    print(jsonEncode(_travelFavorite.toList()));
    // _travelFavorite.add(catalogs);
    notifyListeners();
  }

  void setRemove(TravelModel catalogs) {
    print("setAdd...");
    _travelFavorite.removeWhere(
      (items) => items.scenicSpotId == catalogs.scenicSpotId,
    );
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    print("setLoading...");
    _isLoading = isLoading;
    notifyListeners();
  }

  void setIsTop(bool isTop) {
    // print("setIsTop...");
    _isTop = isTop;
    notifyListeners();
  }

  void onSearch(String query) {
    final result = travelList.where((items) {
      final travelTitle = items.scenicSpotName.toString();
      final input = query;
      return travelTitle.contains(input);
    }).toList();
    _travelSearchResult = result;
    notifyListeners();
  }

  void setFavorite() {
    print("setFavorite");
  }
}
