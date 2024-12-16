import 'package:flutter/material.dart';
import 'list.dart';
import 'map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase_service.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Studio Details',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.purple,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'name',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 8.0),
                          Icon(Icons.map, color: Colors.white, size: 16.0),
                          SizedBox(width: 4.0),
                          Text(
                            'SHOW ON MAP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: () {Navigator.pushNamed(context, '/map');},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              ),
              child: Text('mapa', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Opening hours',
                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Open 24 hours',
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text('tekst s opisom plesova', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Spacer(),
      ElevatedButton(
        onPressed: () {
          // Show the popup dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Done"),
                content: Text("Your booking is confirmed"),
                actions: [
                  TextButton(
                    child: Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Text("Book now"),
            ),
          Container(
            color: Colors.orange.withOpacity(0.1),
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wanna see more studios?',
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.0),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {Navigator.pushNamed(context, '/studio');},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text('Show list', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
/*  FirebaseService firebaseService = FirebaseService();

  try {
    Map<dynamic, dynamic> studios = await firebaseService.fetchStudios();
    studios.forEach((key, value) {
      print("Studio ID: $key");
      print("Name: ${value['name']}");
      print("Address: ${value['address']}");
      print("Description: ${value['description']}");
      print("Geolocation: ${value['geolocation']}");
      print("Dances: ${value['dances']}\n");
    });
  } catch (e) {
    print("Error: $e");
  }*/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DetailsScreen(),
    routes: {
      '/studio': (context) => ListScreen(), // Dodaj rutu za novi ekran
      '/map': (context) => MapApp(),
      '/details':(context) => DetailsScreen()
    },
  ));
}