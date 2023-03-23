import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onur_reklam/Database/firebase.dart';

import '../viewModel/stokSorguViewModel.dart';

TextFormField myTextFormFieldWidget(bool enabled, String koleksiyonAdi, TextEditingController controller, QuerySnapshot<Map<String, dynamic>> documentsData, int index, QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return TextFormField(
      
      enabled: enabled,
                            decoration: const InputDecoration(
                                // labelText: data['yazi']
                                ),
                            controller: controller,
                            onChanged: (value) async {},
                            onEditingComplete: () async {
                              await StokSorguViewModel(FirebaseDb()).updateDoc(
                                  koleksiyonAdi,
                                  controller.text,
                                  documentsData.docs[index]
                                      .id); //FirebaseDb().updateDoc('stoksorgu', controller.text,documentsData.docs[index].id );
                              controller.text == ""
                                  ? await StokSorguViewModel(FirebaseDb())
                                      .delete(koleksiyonAdi, data.id)
                                  : null; //FirebaseDb().delete('stoksorgu', data.id) : null;

                              //setState(() {});
                            },
                          );
  }

  /*
  TextFormField(
                              decoration: const InputDecoration(
                                  // labelText: data['yazi']
                                  ),
                              controller: controller,
                              onChanged: (value) async {},
                              onEditingComplete: () async {
                                await StokSorguViewModel(FirebaseDb()).updateDoc(
                                    'stoksorgu',
                                    controller.text,
                                    documentsData.docs[index]
                                        .id); //FirebaseDb().updateDoc('stoksorgu', controller.text,documentsData.docs[index].id );
                                controller.text == ""
                                    ? await StokSorguViewModel(FirebaseDb())
                                        .delete("stoksorgu", data.id)
                                    : null; //FirebaseDb().delete('stoksorgu', data.id) : null;

                                setState(() {});
                              },
                            ),*/