import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_wise/constants/app_colors.dart';
import 'package:weather_wise/constants/app_styles.dart';
import 'package:weather_wise/screens/weather_home.dart';
import 'package:weather_wise/services/api_services.dart';
import 'package:weather_wise/services/geo_locator.dart';
import 'package:weather_wise/utils/market_data.dart'; // Custom geolocator function
import 'package:http/http.dart' as http;

class WeatherSearchScreen extends StatefulWidget {
  const WeatherSearchScreen({super.key});

  @override
  _WeatherSearchScreenState createState() => _WeatherSearchScreenState();
}

class _WeatherSearchScreenState extends State<WeatherSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final MapController _mapController = MapController();
  List<MarkerData> _markerData = [];
  List<Marker> _markers = [];
  LatLng? _selectedLocation;
  LatLng? _mylocation;
  LatLng? _draggedPosition;
  bool _isDragging = false;
  List<dynamic> _searchResults = [];
  bool _isSearching = false;
  LatLng? _currentLatlng;
  bool mapopen = false;
  // Method to get the user's current location
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await determinePosition(); // Your geolocator function
      _currentLatlng = LatLng(position.latitude, position.longitude);
      _mapController.move(_currentLatlng!, 15.0); // Move to user location
      setState(() {
        _mylocation = _currentLatlng;
      });
      _addMarker(_currentLatlng!);
    } catch (e) {
      print(e);
    }
  }

  void _addMarker(LatLng position) {
    setState(() {
      _markerData.add(MarkerData(position: position));
      _markers.add(Marker(
        point: position,
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () {
            // _addMarker(position);
            // _showMarkerInfo(MarkerData(position: position));
          },
          child: Icon(Icons.location_on, color: Colors.redAccent, size: 40),
        ),
      ));
    });
  }

  void _showMarkerInfo(MarkerData marketData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }

// ! ai generated
  void _removeMarker(LatLng position) {
    setState(() {
      _markerData.removeWhere((marker) => marker.position == position);
      _markers.removeWhere((marker) => marker.point == position);
    });
  }

  Future<void> _searchPlaces(String query) async {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    final url =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&limit=5';

    final response = await http.get(Uri.parse(url));
    final data = json.decode(response.body);
    // log(data);
    if (data.isNotEmpty) {
      setState(() {
        _isSearching = true;
        _searchResults = data;
        // log(_searchResults.toString());
      });
    } else {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
    }
  }

// move to specific location
  void _moveToLocation(double lat, double lon) {
    LatLng location = LatLng(lat, lon);
    _mapController.move(location, 15.0);
    setState(() {
      _selectedLocation = location;
      _searchResults = [];
      _isSearching = false;
      _searchController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(
      () {
        _searchPlaces(_searchController.text);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Center(
            child: Text(
              'Pick Location',
              textAlign: TextAlign.center,
              style: AppStyles.h1,
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Find the area or city that you want to know the detailed weather info at this time',
              textAlign: TextAlign.center,
              style: AppStyles.subtitleText,
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    // width: 120,
                    child: TextField(
                      controller: _searchController,
                      cursorColor: AppColors.white,
                      style: AppStyles.h3,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        hintStyle: AppStyles.subtitleText,
                        prefixIcon:
                            const Icon(Icons.search, color: AppColors.white),
                        suffixIcon: _isSearching
                            ? IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _isSearching = false;
                                    _searchResults = [];
                                  });
                                },
                                icon: Icon(Icons.clear, color: AppColors.white),
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.grey[800],
                        contentPadding: const EdgeInsets.all(8.0),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.transparent,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isSearching = true;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                //? button for mapddddddddddddddddddddddddddddddddd
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: InkWell(
                    onTap: () async {
                      await _getCurrentLocation();
                    },
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 50,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.location_on_outlined,
                          color: AppColors.white, size: 24),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          //?               Map is here
          Expanded(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlutterMap(
                    mapController: _mapController,
                    options: MapOptions(
                      initialZoom: 13.0,
                      backgroundColor: Colors.grey[800]!,
                      //! yaha se location lat and long lena hai or api me pass krna hai
                      onTap: (tapPosition, LatLng) {
                        _selectedLocation = LatLng;
                        _draggedPosition = _selectedLocation;
                      },
                    ),
                    children: [
                      TileLayer(
                        // Display map tiles from any source
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
                        fallbackUrl:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        // userAgentPackageName: 'com.example.app',
                        tileDisplay: TileDisplay.fadeIn(
                          duration: Duration(seconds: 3),
                        ),
                        // And many more recommended properties!
                      ),
                      MarkerLayer(
                        markers: _markers,
                      ),
                      if (_isDragging && _draggedPosition != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _draggedPosition!,
                              width: 80,
                              height: 80,
                              child: Icon(Icons.location_on,
                                  color: Colors.blue, size: 40),
                            )
                          ],
                        ),
                      if (_mylocation != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: _mylocation!,
                              width: 80,
                              height: 80,
                              child: Icon(Icons.location_on,
                                  color: Colors.red, size: 40),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                if (_isSearching && _searchResults.isNotEmpty)
                  Positioned(
                    top: 0,
                    left: 24,
                    child: Container(
                      height: 200,
                      width: 300,
                      // width: double.infinity,
                      color: Colors.grey[800]!.withOpacity(0.6),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final place = _searchResults[index];
                          return ListTile(
                            contentPadding: EdgeInsets.all(4),
                            title: Text(
                              maxLines: 3,
                              style: TextStyle(color: Colors.white),
                              place['display_name'],
                            ),
                            onTap: () {
                              final lat = double.parse(place['lat']);
                              final lon = double.parse(place['lon']);
                              _moveToLocation(lat, lon);
                            },
                          );
                        },
                      ),
                    ),
                  ),
                _isDragging == false
                    ? Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _isDragging = true;
                                });
                              },
                              backgroundColor: AppColors.lightBlue,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.add_location),
                            )
                          ],
                        ),
                      )
                    : Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  _isDragging = false;
                                });
                              },
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Icon(Icons.wrong_location),
                            )
                          ],
                        ),
                      ),
                Positioned(
                  bottom: 20,
                  right: 20,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      FloatingActionButton(
                        onPressed: () {
                          _getCurrentLocation();
                        },
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.lightBlue,
                        child: Icon(Icons.location_searching_rounded),
                      ),
                      if (_isDragging)
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              if (_draggedPosition != null) {
                                _addMarker(_draggedPosition!);
                              }
                              setState(() {
                                _isDragging = false;
                                // _draggedPosition = null;
                              });
                            },
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            child: Icon(Icons.check),
                          ),
                        ),
                    ],
                  ),
                ),
                _draggedPosition != null
                    ? Positioned(
                        bottom: 20,
                        right: 20,
                        left: 20,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                print('drag position: ' +
                                    _draggedPosition.toString());
                                double lat = _draggedPosition!.latitude;
                                double lon = _draggedPosition!.longitude;
                              },
                              backgroundColor: Colors.green,
                              foregroundColor: AppColors.white,
                              child: Icon(Icons.search),
                            ),
                          ],
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
