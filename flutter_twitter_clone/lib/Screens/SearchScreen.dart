import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Screens/anaekran.dart';
import 'package:http/http.dart' as http show get;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:searchfield/searchfield.dart';


class SearchScreen extends StatefulWidget {

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<dynamic> allUsers = [];
  List<dynamic> foundUsers = [];
  @override
  void initState() {
    getUsers();
    foundUsers = allUsers;
    super.initState();
    setState(() {
      allUsers = allUsers;
    });
  }

  Future<void> getUsers() async {
    var response = await http.get(Uri.parse("http://192.168.2.141/slim3/api/users"));
    allUsers = jsonDecode(response.body);
    //print(allUsers);

    setState(() {
      allUsers = allUsers;
    });

  }

  Future<void> runFilter(String enteredKeyword) async {
    if(enteredKeyword.isEmpty){
      allUsers = allUsers;
    }else {
      allUsers = allUsers.where((users) => users["user_name"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }
    setState(() {
      foundUsers = allUsers;
    });
  }
  /*String _gelenCevap = "";
  Future<void> users() async {
    var response = await http.get(Uri.parse("http://192.168.2.141/slim3/api/users"));
    if(response.statusCode == 200){
      List<Map <String , dynamic>>  gelenJson = jsonDecode(response.body);
      _gelenCevap = gelenJson ["users"][0]["user_name"];
    }else
      _gelenCevap = "Bağlantıda sorun oluştu!!";

    setState(() {

    });
  } */
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.5,
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            hintText: "Twitter'da ara..",
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: TweeterColor,),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear, color: TweeterColor,
              ),
              onPressed: () {},
            ),
            filled: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextField(
              onChanged: (value) => runFilter(value),
              decoration: InputDecoration(labelText: 'Search', suffixIcon: Icon(Icons.search)),),
            SizedBox(height: 20,),
            Expanded(child:ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(allUsers[index]["user_id"]),
                color: Colors.blue,
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: Text(
                    allUsers[index]["user_id"].toString(),
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  title: Text(allUsers[index]["user_name"],
                      style: TextStyle(color: Colors.white)),
                  subtitle: Text('${allUsers[index]["user_surname"].toString()}',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            )
          ],
        ),
      ),

    );
  }
}

