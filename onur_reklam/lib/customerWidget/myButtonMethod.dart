import 'package:flutter/material.dart';

ElevatedButton buttonMethod(Color backColor, double elevation, Color shadowColor,double circular,
 double width,height,   onpressed,Widget text, BuildContext context) {
    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: backColor,
                          elevation: elevation,
                          shadowColor: shadowColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(circular),
                          ),
                          padding:  EdgeInsets.symmetric(
                              horizontal: width, vertical: height)),//Get.width/5, vertical: Get.height/20
                      onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => onpressed,
                      ),
                    );},
                        
                       /*  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StokSorgu(),
                      ),
                    )*/
                    
                       child: text);
}