import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  // Sample data for ATMs
  final List<Map<String, String>> atms = [
    {'name': 'PLODINE', 'address': 'TRG RUDERA BOSKOVCA bb, 33520 SLATINA', 'status': 'Open 24 hours'},
    {'name': 'POSLOVNICA SLATINA', 'address': 'TRG SVETOG JOSIPA 2, 33520 SLATINA', 'status': 'Open 24 hours'},
    {'name': 'ZAGREB', 'address': 'TRG SV. JOSIPA 2, 33520 SLATINA', 'status': 'Open 24 hours'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ATMs"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Placeholder for future filtering logic
                print("Search query: $value");
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: atms.length,
              itemBuilder: (context, index) {
                final atm = atms[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  title: Text(
                    atm['name'] ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(atm['address'] ?? ''),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        atm['status'] ?? '',
                        style: TextStyle(color: Colors.green),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            // Action for showing the map
            print("Show Map button clicked");
          },
          child: Text("SHOW MAP"),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            padding: EdgeInsets.symmetric(vertical: 16.0),
            textStyle: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}


