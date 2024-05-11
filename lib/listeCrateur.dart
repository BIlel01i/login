import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/recupdata.dart'; // Import the RecupRealTimeData class

class DataListProvider {
  final String userId;
  final String field;
  late RecupRealTimeData recupData;
  late List<String> dataList = [];

  // Constructor to initialize the DataListProvider with userId and field
  DataListProvider({required this.userId, required this.field}) {
    recupData = RecupRealTimeData(userId: userId, field: field);
  }

  // Method to fetch data from Firestore and convert it into a list of strings
// Method to fetch data and convert it into a list containing just the raw string
  Stream<List<String>> fetchDataList() {
    return recupData.stream
        .map((DocumentSnapshot<Map<String, dynamic>> snapshot) {
      if (snapshot.data() != null) {
        var data = snapshot.data()!;
        var rawValue = data[field] as String?;
        if (rawValue != null && rawValue.isNotEmpty) {
          // Directly return a list containing the raw string value
          return [rawValue];
        }
      }
      return []; // Return an empty list if there's no data or the data is not valid
    });
  }

  // Widget to display the fetched data in a ListView
  Widget buildDataListWidget() {
    return StreamBuilder<List<String>>(
      stream: fetchDataList(),
      builder: (context, snapshot) {
        // Display loading indicator while waiting for data
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        // Handle possible data errors
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        // Check if there is data and it's not empty
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Build a ListView to display items
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index]),
              );
            },
          );
        }
        // Display this text if no data is available
        return const Text('No items available');
      },
    );
  }
}
