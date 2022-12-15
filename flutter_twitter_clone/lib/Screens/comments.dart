import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_twitter_clone/Constants/Constants.dart';


class CommentsPage extends StatefulWidget {
  final String tweet_id;
  const CommentsPage({Key? key, required this.tweet_id}) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  TextEditingController commentController = TextEditingController();
 List<dynamic> comments = [];
  List<dynamic> foundComments = [];
  @override
  void initState() {
    getComments();
    foundComments = comments;
    super.initState();
    setState(() {
      comments = comments;
    });
  }


  Future<void> getComments() async {
    var response = await http.post(Uri.parse("http://192.168.2.141/slim3/api/listComments"),body: ({
      'profile.tweet_id' : widget.tweet_id
    }));
   comments = jsonDecode(response.body);
    setState(() {
      comments = comments;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yorumlar')),
      body: Padding(
        padding: EdgeInsets.all(12.0),
        child:                       Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              controller: commentController,
              maxLength: 50,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Yorum Girin..',
              ),
              onChanged: (value){},
            ),
            SizedBox(height: 20,),
            Material(
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                onTap: () {

                },
                borderRadius: BorderRadius.circular(30),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 40),
                  child: Text(
                    "Paylaş",
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
        ),/*Column(
          children: [
            SizedBox(height: 20,),
            Expanded(child: ListView.builder(
              itemCount: comments.length,
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
                        comments[index]["user_name"].toString() + " " + comments[index]["user_surname"],
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                    ),
                      SizedBox(height: 20,),
                      Text(
                        comments[index]["yorumlar"].toString(),
                        style: TextStyle(fontSize: 15,),
                      ),
                      SizedBox(height: 15,),
                    ],
                  ), */
                ),
            //))
          //],
        //),
      //),
    );
  }
  Future<void> createComment() async {
    if(commentController.text.isNotEmpty){
      var response = await http.post(Uri.parse("http://192.168.9.128/slim3/api/tweet"), body: ({
        'comments': commentController.text,
        'user_id': id,
      }));
      Map <String , dynamic> resp = jsonDecode(response.body);
    }
  }
}
