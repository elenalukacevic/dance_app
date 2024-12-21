import 'studio.dart';
import 'package:flutter/material.dart';


class DetailsScreen extends StatelessWidget {
  final Studio studio;

  DetailsScreen({required this.studio});

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
          studio.name,
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
                  studio.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(studio.address,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to map screen
                        Navigator.pushNamed(context, '/map');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
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
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/map');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
              ),
              child: Text('MAP', style: TextStyle(color: Colors.white)),
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
                      'Open 24 hours', // Static text for now
                      style: TextStyle(fontSize: 16.0, color: Colors.green),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  studio.description,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
              ],
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {
              // popup for booking
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
                          Navigator.of(context).pop();
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
                  onPressed: () {
                    Navigator.pushNamed(context, '/studio');
                  },
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