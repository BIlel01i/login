import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tawhida_login/pages/BLEpage.dart';
import 'package:tawhida_login/pages/HomePage.dart';
import 'package:tawhida_login/pages/archive.dart';

class NavBar extends StatelessWidget {
  final String userId =
      FirebaseAuth.instance.currentUser?.uid ?? 'defaultUserId';
  NavBar({super.key});
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(userId) // Assuming you have the userId available
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                } else if (snapshot.hasData && snapshot.data!.exists) {
                  var data = snapshot.data!.data()!;
                  var name = data['name'] ?? "No name";
                  return Text(name.toString());
                } else {
                  return Text("No user");
                }
              },
            ),
            accountEmail: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                } else if (snapshot.hasData) {
                  return Text(snapshot.data!.email ?? "No email");
                } else {
                  return Text("No user");
                }
              },
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "lib/images/logotaw.png",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(8, 210, 225, 1),
              image: DecorationImage(
                image: AssetImage('lib/images/GLC.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.black26),
            title: Text("Profile"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.home_filled, color: Colors.black26),
            title: Text("Home"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                            fromLoginPage: false,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.notifications_sharp, color: Colors.black26),
            title: Text("Notifications"),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.folder_open,
              color: Colors.black26,
            ),
            title: Text("Archive DMI"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => archive_Page(userId: userId)));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black26,
            ),
            title: Text("Configure Device "),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => BLEPage()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_month,
              color: Colors.black26,
            ),
            title: Text("Calendrier"),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.black26,
            ),
            title: Text("Log out"),
            onTap: () => signUserOut(),
          ),
        ],
      ),
    );
  }
}
