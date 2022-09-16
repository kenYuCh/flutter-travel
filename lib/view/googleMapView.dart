import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myapp20220914/controller/geoLocation.dart';

import 'package:myapp20220914/model/travelModel.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({
    Key? key,
    required this.items,
  }) : super(key: key);

  final TravelModel items;
  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = <Marker>{};

  Future<void> getCurrentPosition() async {
    final currentPosition = await GPS().determinePosition();
    final cameraPosition = CameraPosition(
      // bearing: 192.8334901395799, // 默認值為 0.0 的方位角表示相機指向北方。 方位角為 90.0 表示相機指向東方。
      target: LatLng(currentPosition.latitude, currentPosition.longitude),
      // tilt: 59.440717697143555, // 相機角度與天底的角度，以度為單位。
      zoom: 19.151926040649414,
    );
    _setMarker(currentPosition.latitude, currentPosition.longitude);
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // 取得當前景點位置座標並設置 Markers to be placed on the map.
  Set<Marker> _setMarker(double latitude, double longitude) {
    final title = widget.items.scenicSpotName.toString();
    final maker = Marker(
      markerId: MarkerId(title),
      position: LatLng(latitude, longitude),
      infoWindow: InfoWindow(title: widget.items.scenicSpotName),
    );
    setState(() {
      _markers.add(maker);
    });

    return _markers;
  }

  // 景點座標
  CameraPosition _getLocation(latitude, longitude) {
    _setMarker(latitude, longitude);
    return CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 16.4746,
    );
  }

  // 當相機開始移動時調用
  void _onCameraMoveStarted() {}

  // 當相機移動結束時調用
  void _onCameraIdle() {}

  void _onMapCreated(GoogleMapController controller, position) {
    _controller.complete(controller);
  }

  void _onTap(LatLng position) {
    // _setMarker(position.latitude, position.longitude);
  }

  void _onLongPress(LatLng position) {
    _setMarker(position.latitude, position.longitude);
  }

  @override
  void initState() {}
  // get travel place gps position

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final positionLat = widget.items.position!.positionLat!.toDouble();
    final positionLon = widget.items.position!.positionLon!.toDouble();
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: true,
        mapType: MapType.normal,
        onLongPress: (argument) => _onLongPress(argument),
        onCameraMoveStarted: () => _onCameraMoveStarted,
        onCameraIdle: () => _onCameraIdle,
        onTap: (argument) => _onTap(argument),
        initialCameraPosition: _getLocation(positionLat, positionLon),
        markers: _markers,
        onMapCreated: (
          GoogleMapController controller,
        ) =>
            _onMapCreated(controller, widget),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: getCurrentPosition,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }
}
