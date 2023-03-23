import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:onur_reklam/Database/firebase.dart';
import 'package:onur_reklam/customerWidget/myTextFormField.dart';
import 'package:onur_reklam/viewModel/stokSorguViewModel.dart';

class AnlasmaliFirmaP extends StatelessWidget {
  const AnlasmaliFirmaP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Anlaşmalı Firmalar"),),

      body: StreamBuilder(
                  stream: StokSorguViewModel(FirebaseDb())
                      .get('anlasmafirma'), //FirebaseDb().get("stoksorgu"),
                  builder: (context, snapshot) {
                    QuerySnapshot<Map<String, dynamic>>? documentsData = snapshot.data;

                    return 
              snapshot.data == null ? const Center(child: CircularProgressIndicator()) :
                    
                    ListView.builder(
                      itemCount: documentsData!.docs.isEmpty ? 0 : documentsData.docs.length,
                      itemBuilder: (context, index) {
                        final data = documentsData.docs[index];
//print(documentsData.docs[0].id);

                        TextEditingController controller =
                            TextEditingController(text: data['yazi']);

                        return ListTile(
                            
                            title: myTextFormFieldWidget(false, "anlasmafirma",controller, documentsData, index, data));
                      },
                    );
                  }),
    );
    
  }
}