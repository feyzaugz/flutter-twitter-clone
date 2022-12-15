import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:flutter_twitter_clone/Screens/ProfileScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController(); // düzenlenebilir bir text editing
  TextEditingController surnameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  saveProfile(){
    _formKey.currentState!.save();
    if(_formKey.currentState!.validate() && !_isLoading){
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          Stack( //üst üste hizalama
            children: [
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: TweeterColor,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'images/coverImageFeyza.jpg',
                    ),                  ),
                ),
              ),
              Container(
                height: 150,
                color: Colors.black54,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt,
                    size: 70,
                      color: Colors.white,
                    ),
                    Text(
                      'Arka Planı Değiştirin',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            transform: Matrix4.translationValues(0, -40, 0),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 45,
                          backgroundImage: AssetImage(
                            'images/profileFeyza.png',
                          ),
                        ),
                        CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.black54,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(Icons.camera_alt,
                                size: 35,
                                color: Colors.white,
                              ),
                              Text(
                                'Profil Fotoğrafını Değiştirin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                      GestureDetector(
                        onTap: (){
                         editProfile();
                        },
                        child: Container(
                          width: 100,
                          height: 35,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: TweeterColor,
                          ),
                          child: Center(
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                Form(
                  key: _formKey,
                    child:Column(
                      children: [
                        SizedBox(height: 20, ),
                        TextFormField(
                          controller: nameController,
                          //initialValue: name,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(
                              color: TweeterColor,),
                          ),
                          validator: (input) => input!.trim().length<2?
                          'Lütfen geçerli bir isim girin':null,
                          onSaved: (value){
                            name = value!;
                          },
                        ),
                        SizedBox(height: 20, ),
                        TextFormField(
                          controller: surnameController,
                          //initialValue: surname,
                          decoration: InputDecoration(
                            labelText: 'Surname',
                            labelStyle: TextStyle(
                              color: TweeterColor,),
                          ),
                          validator: (input) => input!.trim().length<2?
                          'Lütfen geçerli bir soyisim girin':null,
                          onSaved: (value){
                            surname = value!;
                          },
                        ),
                        SizedBox(height: 20, ),
                        TextFormField(
                          controller: bioController,
                          //initialValue: bio,
                          decoration: InputDecoration(
                            labelText: 'Bio',
                            labelStyle: TextStyle(
                              color: TweeterColor,),
                          ),
                          onSaved: (value){
                            bio = value!;
                          },
                        ),
                        SizedBox(height: 20, ),
                        TextFormField(
                          controller: emailController,
                          //initialValue: email,
                            decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(
                              color: TweeterColor,),
                          ),
                          onSaved: (value){
                            bio = value!;
                          },
                        ),
                        SizedBox(height: 20,),
                        _isLoading?
                            CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(TweeterColor),
                            )
                            :SizedBox.shrink(),
                      ],
                    ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Future<void> editProfile() async {
    if (id.isNotEmpty && nameController.text.isNotEmpty && surnameController.text.isNotEmpty && bioController.text.isNotEmpty
    &&emailController.text.isNotEmpty) {

      var response = await http.post(
          Uri.parse("http://192.168.9.128/slim3/api/editProfile"), body: ({
        'user_id': id,
        'user_name': nameController.text,
        'user_surname': surnameController.text,
        'user_bio' : bioController.text,
        'user_email' : emailController.text,
      }));

      name = nameController.text;
      surname = surnameController.text;
      bio = bioController.text;
      email = emailController.text;

      if (response.statusCode == 200) {

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ProfileScreen(user_id: 'user_id',)));
        SnackBar(content: Text("Başarıyla kaydedildi"),);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Geçersiz Kimlik")));

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lütfen boş alan bırakmayın!!")));
    }
  }
}
