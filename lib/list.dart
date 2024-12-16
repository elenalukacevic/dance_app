import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'studio.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Studio> _studios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStudios();
  }

  Future<void> _fetchStudios() async {
    try {
      // Fetch studios using FirebaseService
      final studios = await _firebaseService.fetchStudios();
      setState(() {
        _studios = studios;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching studios: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studios"),
        backgroundColor: Colors.purple,
      ),

      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _studios.isEmpty
          ? Center(child: Text("error, no data."))
          : ListView.builder(
              itemCount: _studios.length,
              itemBuilder: (context, index) {
                final studio = _studios[index];
                return ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  title: Text(
                    studio.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(studio.address),
                onTap: () {
                  Navigator.pushNamed(context, '/details');
            },
          );
        },
      ),
    );
  }
}



