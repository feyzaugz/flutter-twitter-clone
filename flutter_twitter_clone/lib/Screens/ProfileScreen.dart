import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Screens/EditProfileScreen.dart';
import 'package:flutter_twitter_clone/Screens/anaekran.dart';
import 'package:flutter_twitter_clone/Screens/comments.dart';
import 'package:flutter_twitter_clone/users/authentication/login_screen.dart';
import 'package:http/http.dart' as http;


class ProfileScreen extends StatefulWidget {
  final String user_id;

  const ProfileScreen({Key? key, required this.user_id}) : super(key: key);


  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<dynamic> userTweets = [];
  List<dynamic> foundTweets = [];


  @override
  void initState() {
    getTweets();
    foundTweets = userTweets;
    super.initState();
    setState(() {
      userTweets = userTweets;
    });
  }
Future<void> getTweets() async {
  var response = await http.post(Uri.parse("http://192.168.2.141/slim3/api/listTweet"), body: ({
    'user_id' : widget.user_id,
  }));
  userTweets = jsonDecode(response.body);
  //print(userTweets);
  setState(() {
    userTweets = userTweets;
  });
}


  TextEditingController nameController = TextEditingController(); // düzenlenebilir bir text editing
  TextEditingController surnameController = TextEditingController(); // düzenlenebilir bir text editing
  TextEditingController tweetsController = TextEditingController(); // düzenlenebilir bir text editing

  int _profileSegmentedValue = 0;
  Map<int, Widget> _profileTabs = <int, Widget>{
    0:Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:     Text(
        'Tweets',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
    1:Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child:     Text(
        'Likes',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    ),
  };
  BuildProfileWidgets(){
    switch(_profileSegmentedValue){
      case 0:
         return Center(
           child: Column(
         children: [
         SizedBox(height: 100000,
             child: ListView.builder(
               itemCount: userTweets.length,
               itemBuilder: (context, index) => Container(
                 padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                       children: [
                         CircleAvatar(radius: 20,
                             backgroundImage:  AssetImage(
                               'images/profileFeyza.png',)
                         ),
                         SizedBox(width: 10,),
                         Text(
                           userTweets[index]["user_name"].toString() + " " + userTweets[index]["user_surname"],
                           style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                         ),
                       ],
                     ),
                     SizedBox(height: 20,),
                     Text(
                       userTweets[index]["tweets"].toString(),
                       style: TextStyle(fontSize: 15,),
                     ),
                     SizedBox(height: 15,),
                     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Row(
                           children: [
                             SizedBox(height: 15,),
                             Divider(),
                             IconButton(onPressed: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage(
                                 tweet_id: userTweets[index]["tweet_id"],
                               )));
                             }, icon: Icon(
                               Icons.comment,
                               color: Colors.grey,
                               size: 22,
                             )),
                           ],
                         ),
                       ],
                     ),
                     //SizedBox.shrink(),
                     /* Column(
                      children: [
                        SizedBox(height: 15,),
                        Container(
                          height: 250,
                          decoration: BoxDecoration(
                            color: TweeterColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ), */
                   ],
                 ),
               ),
             )

         ),
    ],
    ),

    );
      case 1:
        return Center(child: Text('Likes',style: TextStyle(fontSize: 25)));
      default:
        return Center(child: Text('Bir şeyler ters gitti!',style: TextStyle(fontSize: 25)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginScreen()));
        },
        child: Icon(Icons.logout_outlined),
        backgroundColor: Colors.blue,
      ),
      body: LayoutBuilder(
        builder: (context, cons) {
          return ListView(
          children: [
            SingleChildScrollView(
              child:Column(
                children: [
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: TweeterColor,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'images/coverImageFeyza.jpg',
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              radius: 35,
                              backgroundImage: AssetImage(
                                'images/profileFeyza.png',
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:
                                (context)=>EditProfileScreen(

                                ),),);
                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  border: Border.all(color: TweeterColor),
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: TweeterColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8,),
                            Text(
                              surname,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10,),
                                  Text(
                                    bio,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  SizedBox(height: 15,),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: CupertinoSlidingSegmentedControl(
                                      groupValue: _profileSegmentedValue,
                                      thumbColor: TweeterColor,
                                      backgroundColor: Colors.blueGrey,
                                      children: _profileTabs,
                                      onValueChanged: (i){
                                        setState(() {
                                          _profileSegmentedValue = i!;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                 BuildProfileWidgets(),
                ],
              ),

            ),
          ],
          );
        }
      ),
    );
  }
}
