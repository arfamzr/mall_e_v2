import 'package:flutter/material.dart';
import 'AdminHome.dart';
import 'profile.dart';

class AdminPage extends StatefulWidget {
  @override
  State<StatefulWidget>createState(){
    return _AdminPage();
  }
}

class _AdminPage extends State<AdminPage> {


  void onTabTapped (int index){
    setState((){
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  final List<Widget>_children = [
    AdminHome(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin"),),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black12,
          type: BottomNavigationBarType.fixed,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items:[
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("Profile")),
            BottomNavigationBarItem(icon: Icon(Icons.lock_open), title: Text("Logout")),
          ]
      ),
    );
  }
}


