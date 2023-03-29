import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onur_reklam/customerWidget/myButtonMethod.dart';
import 'package:onur_reklam/view/IdariBolum/anlasmaliFirmalarView.dart';
import 'package:onur_reklam/view/IdariBolum/fiyatTeklifiView.dart';
import 'package:onur_reklam/view/IdariBolum/karZarar.dart';
import 'package:onur_reklam/view/IdariBolum/onemliNotlar.dart';
import 'package:onur_reklam/view/IdariBolum/personelOrganizeView.dart';
import 'package:onur_reklam/view/IdariBolum/stokIhtiyacView.dart';
import 'package:onur_reklam/view/IdariBolum/stokSorguView.dart';

class IdariView extends StatefulWidget {
  const IdariView({super.key});

  @override
  State<IdariView> createState() => _IdariViewState();
}

class _IdariViewState extends State<IdariView> {
  
  
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        title: const Text("İdari Bölümü"),
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
              children:  [
                
                const SizedBox(height: 50,),
                buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const StokSorgu() ,
                         const Text("Stok Sorgulama"), context),

                        const SizedBox(height: 50,),

                           buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const StokIhtiyac() ,
                         const Text("    Stok İhtiyaç  "), context),
            
                const SizedBox(height: 50,),
            
                        buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const PersonelOrganize() ,
                         const Text("Personel Organize"), context),
            
                const SizedBox(height: 50,),
            
                        buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const AnlasmaliFirmalar() ,
                         const Text("Anlaşmalı Firmalar"), context),
            
                        const SizedBox(height: 50,),
            
                        buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const FiyatTeklifiSablon() ,
                         const Text("Fiyat Teklifi Şablon"), context),
                        const SizedBox(height: 50,),

                           buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const KarZarar() ,
                         const Text("Kar-Zarar Gelir-Gider"), context),

                        const SizedBox(height: 50,),

                           buttonMethod(Colors.red, 40, Colors.green, 50, Get.width/5, Get.height/20,
                const OnemliNotlar() ,
                         const Text("Önemli Notlar"), context),
                        const SizedBox(height: 50,),
   
              ],
            ),
          ),
        ),
      ),
    );
  }
}