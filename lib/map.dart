import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'firebase_service.dart';
import 'studio.dart';
import 'details.dart';
import 'list.dart';

class MapApp extends StatefulWidget {
  final LatLng? initialLocation;

  MapApp({this.initialLocation});

  @override
  _MapAppState createState() => _MapAppState();
}

class _MapAppState extends State<MapApp> {
  final FirebaseService firebaseService = FirebaseService();
  Studio? _selectedStudio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          FutureBuilder<List<Studio>>(
            future: firebaseService.fetchStudios(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No studios found.'));
              }

              final studios = snapshot.data!;
              final markers = studios.map((studio) {
                return Marker(
                  point: LatLng(
                    studio.geolocation['latitude']!,
                    studio.geolocation['longitude']!,
                  ),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedStudio = studio;
                      });
                    },
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.purple,
                      size: 30.0,
                    ),
                  ),
                );
              }).toList();

              return FlutterMap(
                options: MapOptions(
                  center: widget.initialLocation ??
                      LatLng(45.8150, 15.9819), // Zagreb
                  zoom: widget.initialLocation != null ? 15.0 : 13.0, // Zoom in
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: markers),
                ],
              );
            },
          ),
          if (_selectedStudio != null)
            Center(
              child: AlertDialog(
                title: Text(_selectedStudio?.name ?? "Unknown Studio"),
                content: Text(_selectedStudio?.address ?? "No Address Provided"),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedStudio = null;
                      });
                    },
                    child: Text("Close"),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_selectedStudio != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailsScreen(studio: _selectedStudio!),
                          ),
                        ).then((_) {
                          setState(() {
                            _selectedStudio = null;
                          });
                        });
                      }
                    },
                    child: Text("See More"),
                  ),
                ],
              ),
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                ),
                child: Text(
                  "LIST",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}








