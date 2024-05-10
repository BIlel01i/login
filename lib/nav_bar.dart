import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("imen"),
            accountEmail: const Text("imen.ayari@gmail.com"),
            currentAccountPicture: CircleAvatar(
                child: ClipOval(
              child: Image.asset("lib/images/logotaw.png",
                  width: 90, height: 90, fit: BoxFit.cover),
            )),
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
            onTap: () {},
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
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.black26,
            ),
            title: Text("Paramétre"),
            onTap: () {},
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