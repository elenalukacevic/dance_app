import 'package:firebase_database/firebase_database.dart';
import 'studio.dart';

class FirebaseService {
  final DatabaseReference ref = FirebaseDatabase.instance.ref("studios");

  Future<List<Studio>> fetchStudios() async {
    try {
      DataSnapshot snapshot = await ref.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        return data.entries.map((entry) {
          final studioData = Map<String, dynamic>.from(entry.value as Map);
          return Studio.fromMap(studioData, entry.key);
        }).toList();
      } else {
        throw Exception("No data found in the database.");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}

