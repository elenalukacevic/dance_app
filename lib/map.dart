import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'firebase_service.dart';
import 'studio.dart';

class MapApp extends StatelessWidget {
  final FirebaseService firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Map'),
          backgroundColor: Colors.purple,
        ),
        body: FutureBuilder<List<Studio>>(
          future: firebaseService.fetchStudios(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error fetching data: ${snapshot.error}'));
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
                builder: (ctx) => Icon(
                  Icons.location_pin,
                  color: Colors.purple,
                  size: 30.0,
                ),
              );
            }).toList();

            return FlutterMap(
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
            );
          },
        ),
      ),
    );
  }
}





