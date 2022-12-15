//import 'dart:js';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/Screens/anaekran.dart';
import 'package:flutter_twitter_clone/Constants/Constants.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


import 'signup_screen.dart';




class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(); // düzenlenebilir bir text editing
  TextEditingController passwordController = TextEditingController();
  bool invisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(key: scaffoldKey,
      body: LayoutBuilder(
        builder: (context, cons) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: cons.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //login screen header
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    height: 300,
                    child: Image.asset(
                      "images/tw.png",
                    ),
                  ),

                  //login screen sign-in form
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffe1f5fe),
                        borderRadius: BorderRadius.all(
                          Radius.circular(40), //box'ın kenarlarını yuvarlama
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2, // kutunun etrafının blurluk değeri
                            color: Colors.white,
                            offset: Offset(0, -2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: Column(
                          children: [
                            //email , password, login part
                            Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  //email textform
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) =>
                                    val == ""
                                        ? "Please write email"
                                        : null,
                                    //bir hata mesajı. Eğer email boş bırakılmışsa hata mesajı gönderecek
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Color(0xff536471),
                                      ),
                                      hintText: "example@gmail.com",
                                      labelText: "email",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ),
                                      //  Dekorasyon kutusunun çevresine çizilecek kenarlığın şekli.
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ),
                                      //InputDecoration etkinleştirildiğinde ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ),
                                      //InputDecorator odağa sahip olduğunda ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets
                                          .symmetric(
                                        horizontal: 20, vertical: 15,),
                                      fillColor: Colors.white,
                                      //Dekorasyonun kap renginin temel dolgu rengi.
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  //password textform
                                  TextFormField(
                                    obscureText: invisible,
                                    controller: passwordController,
                                    validator: (val) =>
                                    val == ""
                                        ? "Please write email"
                                        : null,
                                    //bir hata mesajı. Eğer email boş bırakılmışsa hata mesajı gönderecek
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key,
                                        color: Color(0xff536471),
                                      ),
                                      hintText: "password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ),
                                      //  Dekorasyon kutusunun çevresine çizilecek kenarlığın şekli.
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ),
                                      //InputDecoration etkinleştirildiğinde ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ),
                                      //InputDecorator odağa sahip olduğunda ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets
                                          .symmetric(
                                        horizontal: 20, vertical: 15,),
                                      fillColor: Colors.white,
                                      //Dekorasyonun kap renginin temel dolgu rengi.
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: invisible ? Icon(
                                            Icons.visibility_off) : Icon(
                                            Icons.visibility),
                                        onPressed: togglePasswordVisibility, //şifreyi görünür yapma ve saklama işlemi
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 20,),

                                  //Login Button
                                  Material(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        login();
/*http("http://localhost/api_twitter_clone/slim/public/user/login").post({
  "user_name": username,
  "pass": pass
}).() */
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 50),
                                        child: Text(
                                          "Giriş Yap",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 16,),
                            //don't have an account part
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Henüz bir hesabınız yok mu?",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                                  },
                                  child: const Text(
                                      "Kaydolun"
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void togglePasswordVisibility() => setState(() => invisible = !invisible);

  Future<void> login() async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://192.168.2.141/slim3/api/login"), body: ({
        'user_email': emailController.text,
        'user_password': passwordController.text
      }));
      Map <String , dynamic> resp = jsonDecode(response.body);
      //Map <String, dynamic> userProfile = jsonDecode(resp["user"][0]);
      name = resp["user"][0]["user_name"];
      id = resp["user"][0]["user_id"];
      email = resp["user"][0]["user_email"];
      //print(name);
      surname = resp["user"][0]["user_surname"];
      bio = resp["user"][0]["user_bio"];
      //print(followers);
      //storage.write(key: "token", value: response.body);
      //storage.read(key: "name");
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => anaekran()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Geçersiz Kimlik")));

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hatalı Giriş!!")));
    }
  }
}
