import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Save {
  final String userId;

  Save(this.userId);

  Future<void> saveData(Map<String, String> sensorData) async {
    // Generate the current date and time as a string
    String currentDate =
        DateFormat('yyyy-MM-dd_HH:mm:ss').format(DateTime.now());

    // Create a map to save to Firestore
    Map<String, dynamic> dataToSave = {
      'temperature': sensorData['temperature'],
      'bpm': sensorData['bpm'],
      'bloodSugar': sensorData['bloodSugar'],
      'ecg': sensorData['ecg'],
      'emg': sensorData['emg'],
      'spo2': sensorData['spo2'],
    };

    // Get the document reference
    DocumentReference userDoc =
        FirebaseFirestore.instance.collection('Users').doc(userId);

    // Update the document with the new data
    await userDoc.set({currentDate: dataToSave}, SetOptions(merge: true));
  }
}
