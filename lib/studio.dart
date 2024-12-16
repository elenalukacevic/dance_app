class Studio {
  final String id;
  final String name;
  final String address;
  final String description;
  final Map<String, double> geolocation;
  final List<String> dances;

  Studio({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.geolocation,
    required this.dances,
  });

  // Factory method to create a Studio object from a Map (from Firebase)
  factory Studio.fromMap(Map<String, dynamic> data, String id) {
    return Studio(
      id: id,
      name: data['name'] ?? 'empty',
      address: data['address'] ?? 'empty',
      description: data['description'] ?? 'empty',
      geolocation: {
        'latitude': (data['geolocation']['latitude'] as num).toDouble(),
        'longitude': (data['geolocation']['longitude'] as num).toDouble(),
      },
      dances: List<String>.from(data['dances'] ?? []),
    );
  }

  // Convert a Studio object to a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'description': description,
      'geolocation': geolocation,
      'dances': dances,
    };
  }
}




