import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Property
  late Position currentPosition;    // GPS 신호 가져오는
  late double latData;              // 위도 정보
  late double longData;             // 경도 정보
  late MapController mapController; // 지도 제어
  late bool canRun;                 // GPS 신호를 받았냐?

  @override
  void initState() {
    super.initState();
    canRun = false;
    mapController = MapController();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. 위치 서비스(GPS)가 켜져 있는지 확인
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('위치 서비스가 꺼져 있습니다. 설정에서 켜주세요.')),
        );
      }
      return;
    }

    // 2. 권한 상태 확인
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('위치 권한이 거부되었습니다.')),
          );
        }
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('위치 권한이 영구적으로 거부되었습니다. 설정에서 권한을 허용해주세요.')),
        );
      }
      return;
    }

    // 3. 모든 조건 통과 시 위치 가져오기
    try {
      Position position = await Geolocator.getCurrentPosition();
      currentPosition = position;
      canRun = true;
      latData = currentPosition.latitude;
      longData = currentPosition.longitude;
      print("-------> lat : $latData, long : $longData");
      setState(() {});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('위치 정보를 가져오지 못했습니다: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: canRun
            ? flutterMap()
            : Center(child: CircularProgressIndicator())
            ,
    );
  } // build

  // widget
  Widget flutterMap(){
        return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        initialCenter: LatLng(latData, longData), initialZoom: 17.0
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'com.mega.gpsmappapp',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80,
              height: 80,
              point: LatLng(latData, longData),  
              child: Column(
                children: [
                  SizedBox(
                    child: Text(
                      '현재 위치',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.pin_drop,
                    size: 50,
                    color: Colors.red,
                  )
                ],
              )
            )
          ]
        )
      ]
    );
  }
} // class