import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RecupRealTimeData {
  final String field; // Can be 'temperature', 'ECG', etc.
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> stream;

  // Here, we're assuming the user ID is fetched internally within the class.
  RecupRealTimeData({required this.field}) {
    final userId = FirebaseAuth.instance.currentUser?.uid ??
        'defaultUserId'; // Default or fallback user ID
    stream =
        FirebaseFirestore.instance.collection('Users').doc(userId).snapshots();
  }

  // Widget to build and display data fetched from Firestore
  Widget buildStreamWidget() {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while waiting for data
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          // Display an error if something went wrong
          print('Firestore Error: ${snapshot.error}');
          return Text('Error: ${snapshot.error.toString()}',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.bold));
        }

        if (snapshot.hasData && snapshot.data!.data() != null) {
          // If data is present, display it
          var data = snapshot.data!.data()!;
          var value = data[field] ?? 'Unavailable';
          return Text('Value of $field: $value',
              style: const TextStyle(fontSize: 16));
        }

        // Display this text if no data is available
        return const Text('No data available', style: TextStyle(fontSize: 16));
      },
    );
  }
}
