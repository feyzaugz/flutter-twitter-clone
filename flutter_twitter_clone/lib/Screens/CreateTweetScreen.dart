import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Screens/anaekran.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class CreateTweetScreen extends StatefulWidget {
  const CreateTweetScreen({Key? key}) : super(key: key);

  @override
  State<CreateTweetScreen> createState() => _CreateTweetScreenState();
}

class _CreateTweetScreenState extends State<CreateTweetScreen> {
  TextEditingController tweetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TweeterColor,
        centerTitle: true,
        title: Text(
          'Tweet',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 3,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: tweetController,
              maxLength: 50,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: 'Tweet Girin..',
              ),
              onChanged: (value){},
            ),
            SizedBox(height: 20,),
            Material(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {
                  createTweet();
                },
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 50),
                  child: Text(
                    "Tweet",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ),
            /*ElevatedButton(onPressed: null,
              child: Text(
                'Tweet',
              style: TextStyle(color: Colors.blue),),
            ), */
          ],
        ),
      ),
    );
  }
  Future<void> createTweet() async {
    if (tweetController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://192.168.2.141/slim3/api/tweet"), body: ({
        'tweets': tweetController.text,
        'user_id': id,
      }));
      //Map <String , dynamic> resp = jsonDecode(response.body);
      //Map <String, dynamic> userProfile = jsonDecode(resp["user"][0]);
      //tweets = resp["profile"][0]["tweets"];
      //id;
      //tweetId = resp["profile"][0]["tweet_id"];
      //print(name);
      //print(followers);
      //storage.write(key: "token", value: response.body);
      //storage.read(key: "name");
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => anaekran()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Bir sorun oluştu!!")));

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hatalı Giriş!!")));
    }
  }

}
