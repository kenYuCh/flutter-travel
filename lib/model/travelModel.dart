// To parse this JSON data, do
//
//     final travelModel = travelModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TravelModel travelModelFromJson(String str) =>
    TravelModel.fromJson(json.decode(str));

String travelModelToJson(TravelModel data) => json.encode(data.toJson());

class TravelModel {
  TravelModel({
    required this.scenicSpotId,
    required this.scenicSpotName,
    required this.descriptionDetail,
    required this.phone,
    required this.zipCode,
    required this.openTime,
    required this.picture,
    required this.position,
    required this.class1,
    required this.level,
    required this.parkingPosition,
    required this.city,
    required this.srcUpdateTime,
    required this.updateTime,
  });

  String? scenicSpotId;
  String? scenicSpotName;
  String? descriptionDetail;
  String? phone;
  String? zipCode;
  String? openTime;
  Picture? picture;
  Position? position;
  String? class1;
  String? level;
  ParkingPosition? parkingPosition;
  String? city;
  DateTime? srcUpdateTime;
  DateTime? updateTime;

  factory TravelModel.fromJson(Map<String, dynamic> json) => TravelModel(
        scenicSpotId:
            json["ScenicSpotID"] == null ? null : json["ScenicSpotID"],
        scenicSpotName:
            json["ScenicSpotName"] == null ? null : json["ScenicSpotName"],
        descriptionDetail: json["DescriptionDetail"] == null
            ? null
            : json["DescriptionDetail"],
        phone: json["Phone"] == null ? null : json["Phone"],
        zipCode: json["ZipCode"] == null ? null : json["ZipCode"],
        openTime: json["OpenTime"] == null ? null : json["OpenTime"],
        picture:
            json["Picture"] == null ? null : Picture.fromJson(json["Picture"]),
        position: json["Position"] == null
            ? null
            : Position.fromJson(json["Position"]),
        class1: json["Class1"] == null ? null : json["Class1"],
        level: json["Level"] == null ? null : json["Level"],
        parkingPosition: json["ParkingPosition"] == null
            ? null
            : ParkingPosition.fromJson(json["ParkingPosition"]),
        city: json["City"] == null ? null : json["City"],
        srcUpdateTime: json["SrcUpdateTime"] == null
            ? null
            : DateTime.parse(json["SrcUpdateTime"]),
        updateTime: json["UpdateTime"] == null
            ? null
            : DateTime.parse(json["UpdateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "ScenicSpotID": scenicSpotId == null ? null : scenicSpotId,
        "ScenicSpotName": scenicSpotName == null ? null : scenicSpotName,
        "DescriptionDetail":
            descriptionDetail == null ? null : descriptionDetail,
        "Phone": phone == null ? null : phone,
        "ZipCode": zipCode == null ? null : zipCode,
        "OpenTime": openTime == null ? null : openTime,
        "Picture": picture == null ? null : picture!.toJson(),
        "Position": position == null ? null : position!.toJson(),
        "Class1": class1 == null ? null : class1,
        "Level": level == null ? null : level,
        "ParkingPosition":
            parkingPosition == null ? null : parkingPosition!.toJson(),
        "City": city == null ? null : city,
        "SrcUpdateTime":
            srcUpdateTime == null ? null : srcUpdateTime!.toIso8601String(),
        "UpdateTime": updateTime == null ? null : updateTime!.toIso8601String(),
      };
}

class ParkingPosition {
  ParkingPosition();

  factory ParkingPosition.fromJson(Map<String, dynamic> json) =>
      ParkingPosition();

  Map<String, dynamic> toJson() => {};
}

class Picture {
  Picture({
    required this.pictureUrl1,
    required this.pictureDescription1,
  });

  String? pictureUrl1;
  String? pictureDescription1;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        pictureUrl1: json["PictureUrl1"] == null ? null : json["PictureUrl1"],
        pictureDescription1: json["PictureDescription1"] == null
            ? null
            : json["PictureDescription1"],
      );

  Map<String, dynamic> toJson() => {
        "PictureUrl1": pictureUrl1 == null ? null : pictureUrl1,
        "PictureDescription1":
            pictureDescription1 == null ? null : pictureDescription1,
      };
}

class Position {
  Position({
    required this.positionLon,
    required this.positionLat,
    required this.geoHash,
  });

  double? positionLon;
  double? positionLat;
  String? geoHash;

  factory Position.fromJson(Map<String, dynamic> json) => Position(
        positionLon:
            json["PositionLon"] == null ? null : json["PositionLon"].toDouble(),
        positionLat:
            json["PositionLat"] == null ? null : json["PositionLat"].toDouble(),
        geoHash: json["GeoHash"] == null ? null : json["GeoHash"],
      );

  Map<String, dynamic> toJson() => {
        "PositionLon": positionLon == null ? null : positionLon,
        "PositionLat": positionLat == null ? null : positionLat,
        "GeoHash": geoHash == null ? null : geoHash,
      };
}
