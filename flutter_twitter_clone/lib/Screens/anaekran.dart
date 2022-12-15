import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Screens/CreateTweetScreen.dart';
import 'package:flutter_twitter_clone/Screens/Settings.dart';
import 'package:flutter_twitter_clone/users/authentication/login_screen.dart';

import 'package:http/http.dart' as http;
import 'CreateTweetScreen.dart';
import 'HomeScreen.dart';
import 'NotificationsScreen.dart';
import 'ProfileScreen.dart';
import 'SearchScreen.dart';

final String username = name;

class anaekran extends StatefulWidget {

  @override
  State<anaekran> createState() => _anaekranState();
}

class _anaekranState extends State<anaekran> {
  TextEditingController nameController = TextEditingController(); // düzenlenebilir bir text editing
  TextEditingController surnameController = TextEditingController(); // düzenlenebilir bir text editing

  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          /*children: [
            Container(
             height: 200,
              color: Colors.blue,
              child: ListTile(
                title: Text(name),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings,),
              title:   Text('Ayarlar'),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));              },
            ),
            ListTile(
              leading: Icon(Icons.nightlight,),
              title: const Text('Gece Modu'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ], */
        ),
      ),
      /*appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon (
              Icons.menu_outlined,
                size: 38,
            ),
              onPressed: (){
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        leadingWidth: 50,
        title: Text('Ana Sayfa',),
        actions: [
          Icon(Icons.account_circle_rounded),
        ],
      ),
     drawer: Drawer(
       child: ListView(
         padding: EdgeInsets.zero,
         children: [
           const DrawerHeader(
             decoration: BoxDecoration(
               color: Colors.blue,
             ),
             child: Text('Feyza Uğuz'),
           ),
           ListTile(
             leading: Icon(
               Icons.settings,
             ),
             title: const Text('Ayarlar'),
             onTap: (){
               Navigator.pop(context);
             },
           ),
         ],
       ),
     ), */
     body:
      [
        HomeScreen(),
        SearchScreen(),
        ProfileScreen(user_id: 'user_id'),
      ].elementAt(_selectedTab),
      bottomNavigationBar: CupertinoTabBar(
        onTap: (index){
          setState(() {
            _selectedTab = index;
          });
        },
        activeColor: TweeterColor,
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
      ],
      ),
    );
  }
}
