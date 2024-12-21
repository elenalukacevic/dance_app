import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'firebase_service.dart';
import 'studio.dart';
import 'details.dart';

class MapApp extends StatefulWidget {
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Map'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder<List<Studio>>(
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

          return Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(45.8150, 15.9819), // Zagreb
                  zoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
              if (_selectedStudio != null)
                Center(
                  child: AlertDialog(
                    title: Text(_selectedStudio?.name ?? "empty"),
                    content: Text(_selectedStudio?.address ?? "empty"),
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
                                builder: (context) => DetailsScreen(studio: _selectedStudio!),
                              ),
                            ).then((_) {
                              setState(() {
                                _selectedStudio = null; //close, idk why it is not working without this
                              });
                            });
                          }
                        },
                        child: Text("See More"),
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}








