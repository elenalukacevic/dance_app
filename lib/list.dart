import 'package:flutter/material.dart';
import 'firebase_service.dart';
import 'studio.dart';
import 'details.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  List<Studio> _studios = [];
  List<Studio> _filteredStudios = [];
  String _searchQuery = "";
  String? _selectedDance; // Stores the selected dance filter
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchStudios();
  }

  Future<void> _fetchStudios() async {
    try {
      final studios = await _firebaseService.fetchStudios();
      setState(() {
        _studios = studios;
        _filteredStudios = studios;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching studios: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _filterStudios(String query) {
    setState(() {
      _searchQuery = query;
      _applyFilters();
    });
  }

  void _applyFilters() {
    setState(() {
      _filteredStudios = _studios
          .where((studio) =>
      (_searchQuery.isEmpty ||
          studio.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          studio.address
              .toLowerCase()
              .contains(_searchQuery.toLowerCase())) &&
          (_selectedDance == null ||
              studio.dances.contains(_selectedDance)))
          .toList();
    });
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = "";
      _selectedDance = null;
      _filteredStudios = _studios;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Studios",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search studios",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: _filterStudios,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                // Dropdown filter with examples just to show feature
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedDance,
                    hint: Text("Filter by dance"),
                    isExpanded: true,
                    items: [
                      "Ballet",
                      "Hip-Hop",
                      "Salsa",
                      "Contemporary",
                      "Jazz"
                    ].map((dance) {
                      return DropdownMenuItem(
                        value: dance,
                        child: Text(dance),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDance = value;
                        _applyFilters();
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                // Reset button
                ElevatedButton(
                  onPressed: _resetFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[800],
                  ),
                  child: Text(
                    "Reset",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Studio list
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _filteredStudios.isEmpty
                ? Center(child: Text("No studios found."))
                : ListView.builder(
              itemCount: _filteredStudios.length,
              itemBuilder: (context, index) {
                final studio = _filteredStudios[index];
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsScreen(studio: studio),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/map');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
            ),
              child: Text('MAP', style: TextStyle(color: Colors.white)),
          ),
          )
        )],
      ),
    );
  }
}






