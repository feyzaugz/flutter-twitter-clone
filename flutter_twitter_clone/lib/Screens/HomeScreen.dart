import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Screens/CreateTweetScreen.dart';
import 'package:flutter_twitter_clone/Screens/comments.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:collection';

import 'package:like_button/like_button.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int likeCount = 5;
  bool isLiked = false;
  final double size = 20;
  List<dynamic> likeTweet = [];
  List<dynamic> unlikeTweet = [];

  Future<void> like(isLiked) async {
    var response = await http.post(Uri.parse("http://192.168.2.141/slim3/api/countHeart/likeTweet"),body : ({
      'tweet_id': "tweet_id",
      'user_id' : 'user_id',
      'status' : 'like / unlike'
    }));
    //Map <String , dynamic> resp = jsonDecode(response.body);
    likeTweet = jsonDecode(response.body);

    setState(() {
      likeTweet = likeTweet;
    });
  }

  /*Future<void> unlike() async {
    var response = await http.get(Uri.parse("http://192.168.2.141/slim3/api/countHeart/unlikeTweet"));
    unlikeTweet = jsonDecode(response.body);

    setState(() {
      unlikeTweet = unlikeTweet;
    });
  }*/


  /*initTweetLikes() async {
    var response = await http.get(Uri.parse("http://192.168.2.141/slim3/api/countHeart"));
    Map <String , dynamic> resp = jsonDecode(response.body);
    likes = resp["profile"][0]["likes"];
    //bool isLiked = await response.isLikeTweet();
    setState(() {
      isLiked = isLiked;
    });
  } */
  /* initTweetLikes() async {
    if(isLiked){
      //unlike();
      setState(() {
        isLiked = false;
        likeCount--;
        //unlikeTweet;
      });
    }else {
      //like();
      setState(() {
        isLiked = true;
        likeCount++;
        //likeTweet;
      });
    }
  } */

  List<dynamic> allTweets = [];
  List<dynamic> foundTweets = [];
  int selectedIndex = -1;

  @override
  void initState() {
    getTweets();
    foundTweets = allTweets;
    super.initState();
    setState(() {
      allTweets = allTweets;
    });
  }

  Future<void> getTweets() async {
    var response = await http.post(Uri.parse("http://192.168.2.141/slim3/api/listTweet"));
    allTweets = jsonDecode(response.body);
    //print(allTweets);

    setState(() {
      allTweets = allTweets;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: Container(
          height: 40,
          child: Image.asset('images/tw.png'),
        ),
        title: Text(
          'Ana Sayfa',
          style: TextStyle(
            color: TweeterColor,
          ),
        ),
      ),
      /* drawer: Drawer(
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
      floatingActionButton: FloatingActionButton(
        //child: Icon(Icons.border_color_outlined),
        backgroundColor: Colors.blue,

        child: Image.asset('images/create_tweet.png'),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTweetScreen()));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Expanded(child: ListView.builder(
              itemCount: allTweets.length,
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
                          allTweets[index]["user_name"].toString() + " " + allTweets[index]["user_surname"],
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                       /* Card(
                          key: ValueKey(allTweets[index]["tweet_id"]),
                          color: TweeterColor,
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Column(
                                children: [
                                   ListTile(
                                    leading: Text(
                                      allTweets[index]["user_name"].toString(),
                                      style: TextStyle(fontSize: 24, color: Colors.white,),
                                    ),
                                    title: Text(allTweets[index]["tweets"].toString(),
                                      style: TextStyle(fontSize: 24, color: Colors.white),
                                    ),
                                    subtitle: Text('${allTweets[index]["likes"].toString()}',
                                      style: TextStyle(fontSize: 18, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                        ), */
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text(
                      allTweets[index]["tweets"].toString(),
                      style: TextStyle(fontSize: 15,),
                    ),
                    SizedBox(height: 15,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                LikeButton(
                                  size: size,
                                  isLiked: isLiked,
                                  likeCount: int.parse(allTweets[index]["likes"]),
                                  likeBuilder: (isLiked) {
                                    final color = isLiked ? Colors.red: Colors.grey;
                                    return Icon(Icons.favorite, color: color, size: size);
                                  },
                                  countBuilder: (count, isLiked, text){
                                    final color = isLiked ? Colors.black : Colors.grey;
                                    return Text(
                                      text,
                                      style: TextStyle(
                                        color: color,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                  onTap: (isLiked) async {
                                    like(isLiked);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 15,),
                            Divider(),
                            IconButton(onPressed: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) => CommentsPage(
                               tweet_id: allTweets[index]["tweet_id"],
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
            ))
          ],
        ),
      ),
    );
  }
}
