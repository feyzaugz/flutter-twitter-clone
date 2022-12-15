import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_twitter_clone/users/authentication/login_screen.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Constants.dart';
import '../../Screens/anaekran.dart';


class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  var emailController = TextEditingController(); // düzenlenebilir bir text editing
  var passwordController = TextEditingController();
  bool invisible = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, cons){
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
                    width: MediaQuery.of(context).size.width,
                    height: 200,
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
                                  //Name textform
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) => val == "" ? "Please write name" : null, //bir hata mesajı. Eğer email boş bırakılmışsa hata mesajı gönderecek
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.drive_file_rename_outline,
                                        color: Color(0xff536471),
                                      ),
                                      hintText: "name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ), //  Dekorasyon kutusunun çevresine çizilecek kenarlığın şekli.
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ), //InputDecoration etkinleştirildiğinde ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ), //InputDecorator odağa sahip olduğunda ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15,),
                                      fillColor: Colors.white, //Dekorasyonun kap renginin temel dolgu rengi.
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  //Surname textform
                                  TextFormField(
                                    controller: surnameController,
                                    validator: (val) => val == "" ? "Please write name" : null, //bir hata mesajı. Eğer email boş bırakılmışsa hata mesajı gönderecek
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.sort_by_alpha,
                                        color: Color(0xff536471),
                                      ),
                                      hintText: "surname",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ), //  Dekorasyon kutusunun çevresine çizilecek kenarlığın şekli.
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ), //InputDecoration etkinleştirildiğinde ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ), //InputDecorator odağa sahip olduğunda ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15,),
                                      fillColor: Colors.white, //Dekorasyonun kap renginin temel dolgu rengi.
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  //email textform
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) => val == "" ? "Please write email" : null, //bir hata mesajı. Eğer email boş bırakılmışsa hata mesajı gönderecek
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
                                      ), //  Dekorasyon kutusunun çevresine çizilecek kenarlığın şekli.
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ), //InputDecoration etkinleştirildiğinde ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ), //InputDecorator odağa sahip olduğunda ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15,),
                                      fillColor: Colors.white, //Dekorasyonun kap renginin temel dolgu rengi.
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 20,),

                                  //password textform
                                  TextFormField(
                                    obscureText: invisible,
                                    controller: passwordController,
                                    validator: (val) => val == "" ? "Please write email" : null, //bir hata mesajı. Eğer email boş bırakılmışsa hata mesajı gönderecek
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
                                      ), //  Dekorasyon kutusunun çevresine çizilecek kenarlığın şekli.
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Colors.black,
                                        ),
                                      ), //InputDecoration etkinleştirildiğinde ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ), //InputDecorator odağa sahip olduğunda ve bir hata göstermediğinde görüntülenecek kenarlık .
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide( // box kenarlık
                                          color: Color(0xff01579b),
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 15,),
                                      fillColor: Colors.white, //Dekorasyonun kap renginin temel dolgu rengi.
                                      filled: true,
                                      suffixIcon: IconButton(
                                        icon: invisible ? Icon(Icons.visibility_off) : Icon(Icons.visibility),
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
                                      onTap: (){
                                        register(emailController.text.toString(),passwordController.text.toString(),nameController.text.toString(),surnameController.text.
                                        toString());
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                                        child: Text(
                                          "Kayıt ol",
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
  Future<void> register(String email, String password, String name, String surname, ) async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty && surnameController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://192.168.2.141/slim3/api/register"), body: ({
        'user_email': emailController.text,
        'user_password': passwordController.text,
        'user_name': nameController.text,
        'user_name': nameController.text,
        'user_surname':surnameController.text,
      }));

      if (response.statusCode == 200) {
        SnackBar(content: Text("Başarılı, giriş ekranına yönlendiriliyorsunuz!"));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kullanıcı zaten kayıtlı")));

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Hatalı Giriş!!")));
    }
  }

  void togglePasswordVisibility() => setState(() => invisible = !invisible);
}

