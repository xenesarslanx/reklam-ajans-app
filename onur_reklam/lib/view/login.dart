import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/customerWidget/myButtonMethod.dart';
import 'package:onur_reklam/view/PersonelBolum/personelView.dart';

import 'IdariBolum/IdariView.dart';

class LoginUsers extends StatefulWidget {
  const LoginUsers({super.key});

  @override
  State<LoginUsers> createState() => _LoginUsersState();
}

class _LoginUsersState extends State<LoginUsers> {
  bool _isVisible = false;
  TextEditingController passwordControl = TextEditingController();
  String sifre = "onuronur";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      /*  appBar: AppBar(
          title: const Text("ONUR REKLAM"),
        ),*/
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(    
            decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage("lib/assets/back12.jpg"),
              fit: BoxFit.fill,
            ),
            ),
              height: Get.height,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
            
                  ElevatedButton(
                    //idari buton
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        elevation: 40,
                        shadowColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width / 5,
                            vertical: Get.height / 20)),
                    onPressed: () {
                      setState(() {
                        //   handleButtonPress();
                        _isVisible = !_isVisible;
                      });
                      /*     Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const IdariView(),
                      ),
                        );*/
                    },
                    child: const Text(
                      "idari Giriş    ",
                      textAlign: TextAlign.left,
                    ),
                  ),
            
                  const SizedBox(
                    height: 50,
                  ),

                  //personel buton
            buttonMethod(Colors.blueAccent, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const PersonelView() ,
                         const Text("Personel Giriş"), context),                  
            
                  const SizedBox(
                    height: 10,
                  ),
            
                  Visibility(
                      visible: _isVisible,
                      
                      child: TextFormField(
                        controller: passwordControl,
                        decoration: const InputDecoration(
                          icon: Icon(Icons.password),
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.w300, color: Colors.red),
            
                         
                          hintText: 'Şifrenizi giriniz',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 1,
                        style: const TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w300),
                        onEditingComplete: () {
                          setState(() {
                            sifre == passwordControl.text
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const IdariView(),
                                    ),
                                  )
                                : const SizedBox();
                          });
                        },
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
