import 'package:flutter/material.dart';

// Glycemie page include an image, a title, a description, and extra content.
class GlycemiePage extends StatefulWidget  {
  const GlycemiePage({super.key});

  @override
  _GlycemiePageState createState() => _GlycemiePageState();
}

class _GlycemiePageState extends State<GlycemiePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          image:DecorationImage(
            image: AssetImage('lib/images/background.png'),
            fit:BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 30,
              left:20, 
              child: Padding(
                padding: const EdgeInsets.all (8.0),
                child: Image.asset(
                  'lib/images/logotaw.png',
                  width :130, 
                  height :60, 
        
                ),
              ),
            ),
            Positioned(
              top: 120, // Adjust top position as needed
              left: 30, // Adjust left position as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Glycemie',
                    style: TextStyle(
                      color: Colors.blue, // Change text color as needed
                      fontSize: 16, // Adjust font size as needed
                      fontWeight: FontWeight.bold, // Adjust font weight as needed
                    ),
                  ),
                 
                  
                      
                ],
              ),
            ),
            Positioned(
                top: 200,
                left: 110,
                child: Image.asset(
                  'lib/images/temp3.png', // Replace with your image asset
                  width: 100, // Adjust image width as needed
                  height: 100, // Adjust image height as needed
                ),
            ),
            Positioned(
              top:230,
              left:160, 
              child: Text(
                'mg',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight:FontWeight.bold,
                ),
              ),
            ),
            Positioned(
                top: 280,
                left: -10,
                child: Image.asset(
                  'lib/images/temp4.png', // Replace with your image asset
                  width: 150, // Adjust image width as needed
                  height: 200, // Adjust image height as needed
                ),
            ),
             Positioned(
                top: 280,
                right: -10,
                child: Image.asset(
                  'lib/images/temp5.png', // Replace with your image asset
                  width: 150, // Adjust image width as needed
                  height: 200, // Adjust image height as needed
                ),
            ),
            Positioned(
                bottom: 10,
                right: 20,
                child: Image.asset(
                  'lib/images/Mode_Isolation.png', // Replace with your image asset
                  width: 100, // Adjust image width as needed
                  height: 100, // Adjust image height as needed
                ),
            ),
            Positioned(
            bottom: 150,
            left: 35,
            child: Row(
              children: [
                _buildButton( 'Start',Colors.blue,  () {
                  // Add functionality for button 1
                  print('start pressed');
                }),
                SizedBox(width: 20),
                _buildButton( 'Reset',Colors.blue ,() {
                  // Add functionality for button 2
                  print('Reset pressed');
                }),
                
               
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            left: 35,
            child: Row(
              children: [
                _buildButton( 'Upload',Colors.blue,  () {
                  // Add functionality for button 1
                  print('Upload pressed');
                }),
                SizedBox(width: 20),
                _buildButton( 'Archive',Colors.blue ,() {
                  // Add functionality for button 2
                  print('Archive pressed');
                }),
                
               
              ],
            ),
          ),
          ],
        
        ),
      ),
      
    );

  }
  Widget _buildButton(String text,Color color ,  VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(120, 40), // Set button color
      ),
      
      child: Text(text),
    );
  }
}
