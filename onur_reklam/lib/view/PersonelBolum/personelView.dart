import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/customerWidget/myButtonMethod.dart';
import 'package:onur_reklam/view/PersonelBolum/anlasmaliFirmaPView.dart';
import 'package:onur_reklam/view/PersonelBolum/personelOrganizePView.dart';
import 'package:onur_reklam/view/PersonelBolum/stokSorguPView.dart';

class PersonelView extends StatefulWidget {
  const PersonelView({super.key});

  @override
  State<PersonelView> createState() => _PersonelViewState();
}

class _PersonelViewState extends State<PersonelView> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: const Text("Personel Bölümü"),
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
              image: AssetImage("lib/assets/back2.jpg"),
              fit: BoxFit.fill,
            ),
            ),
            child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
                
              children: [
                const SizedBox(height: 50,),
                buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const StokSorguP() ,
                         const Text("Stok Sorgulama"), context), 
                
                const SizedBox(height: 50,),
                
                       buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const PersonelOrganizeP() ,
                         const Text("Personel Organize"), context), 
                
                const SizedBox(height: 50,),

                buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const AnlasmaliFirmaP() ,
                         const Text("Anlaşmalı Firmalar"), context), 


           SizedBox(height: Get.height/2,),
                        
              ],
            ),
          ),
        ),
      ),
    );
  }
}