import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Class Definition and Constructor
class RecupRealTimeData {
  final String userId;
  final String field; // Can be 'temperature' or 'humidity'
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> stream;

  RecupRealTimeData({required this.userId, required this.field}) {
    // Initialize the stream to continuously listen to changes
    // to a specific Firestore document identified by userId.
    stream =
        FirebaseFirestore.instance.collection('Users').doc(userId).snapshots();
  }

  // Widget to build and display the data
  Widget buildStreamWidget() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        print("User ID: ${FirebaseAuth.instance.currentUser?.uid}");
        if (snapshot.hasError) {
          print('Firestore Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error.toString()}');
        }

        if (snapshot.hasData && snapshot.data!.data() != null) {
          var data = snapshot.data!.data()!;
          var value = data[field] ?? 'Unavailable';
          print('Data: $data'); // Display the data in the console for debugging
          return Text('Value of $field: $value',
              style: TextStyle(fontSize: 16));
        }

        return Text('No data available', style: TextStyle(fontSize: 16));
      },
    );
  }
}
