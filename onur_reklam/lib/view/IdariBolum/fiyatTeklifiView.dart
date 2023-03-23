import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FiyatTeklifiSablon extends StatefulWidget {
  const FiyatTeklifiSablon({super.key});

  @override
  State<FiyatTeklifiSablon> createState() => _FiyatTeklifiSablonState();
}

SnackBar snackBar2 = const SnackBar(
  content: Text("iniyor"),
);
bool downloadPDFloaded = false;

class _FiyatTeklifiSablonState extends State<FiyatTeklifiSablon> {
  Future<File> downloadPDF(String url, String filename) async {
    downloadPDFloaded = true;
    var request = await http.get(Uri.parse(url));
    var bytes = request.bodyBytes;
    var dir = await getApplicationDocumentsDirectory();
    File file = File('${dir.path}/$filename');
    print(file.path);
    await file.writeAsBytes(bytes);
    downloadPDFloaded = false;

    var snackBar = SnackBar(
      content: Text("İndirme İşlemi Başarılı\n, dosya konumu: ${file.path}"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print("işlem tamam");
    return file;
  }

  bool isLoaded = false;
  String baseUrl = "https://";
  List<File> selectedFile = [];
  List<String> fileUrl = [];
  int ilk = 0;
  int son = 0;
  List<String> dosyaAdi = [""];
  String dosyaIsim = "";

  var url2 =
      "firebasestorage.googleapis.com/v0/b/onurreklam-83f58.appspot.com/o/files%2F%5B%2Fdata%2Fuser%2F0%2Fcom.example.onur_reklam%2Fcache%2Ffile_picker%2FOlcmeveDegerlendirme3.pdf%5D%5Bi%5D?alt=media&token=937c3311-41d4-4c2b-bc3c-6103e0edaf86";
  late PdfViewerController pdfController;
  @override
  void initState() {
    pdfController = PdfViewerController();
    super.initState();
  }

  void selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        selectedFile.add(File(
            result.files.single.path!)); // = File(result.files.single.path!);
      });
      print("selectedFile: $selectedFile"); //cihazdaki konumu (pathi)

      print("pathhhHH: ${selectedFile[1].path}");
    }
  }

  void uploadFile() async {
    if (selectedFile.isEmpty) return;
    List<String> fileName = [];
    List<String> destination = [];
    Reference? ref;

    for (int i = 0; i < selectedFile.length; i++) {
      fileName.add(
          selectedFile[i].path); //= selectedFile![i].path.substring(1, 10);
    }
    print("file name $fileName"); // bulundugu klasor
    for (int i = 0; i < fileName.length; i++) {
      destination.add('files/$fileName[i]'); //= 'files/$fileName[i]';
    }

    try {
      for (int i = 0; i < destination.length; i++) {
        ref = FirebaseStorage.instance.ref(destination[
            i]); // files/bulunduğu klasör/ (firebase storagea boyle yükledi)
      }
      for (int i = 0; i < fileName.length; i++) {
        await ref!.putFile(selectedFile[i]);
      }
      final url = await ref!.getDownloadURL();
      setState(() {
        fileUrl.add(
            url); //= url; // fileUrl firebaseStoragedaki konumu (sunucudaki linki)
        print("fileurl $fileUrl");
      });
      // Upload success
      print('File uploaded: $url');
      url2 = url.substring(8);
      var docul = url.substring(url.length - 5);
      ilk = url.indexOf("2Ffile_picker%2F"); //baslangıc
      son = url.indexOf(".pdf"); //son
      dosyaIsim = url.substring(ilk + 16, son + 4); //son+4
      dosyaAdi.add(url.substring(ilk + 16, son + 4));
      print("dosyaa adiiiii $dosyaAdi");

      print("url2 $url2");
      await set("assets", docul, url2, dosyaIsim);
      setState(() {
        selectedFile = [];
      });
    } on FirebaseException catch (e) {
      // Upload failed
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dosya Yükle"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              elevation: 40,
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding:  EdgeInsets.symmetric(
                                  horizontal: Get.width/10, vertical: Get.height/40)),
                  onPressed: () {
                    setState(() {
                      isLoaded = false;
            
                      selectFile();
                    });
                  },
                  child: const Text("Dosya Seç")),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              elevation: 40,
                              shadowColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding:  EdgeInsets.symmetric(
                                  horizontal: Get.width/10, vertical: Get.height/40)),
                  onPressed: () {
                    setState(() {
                      uploadFile();
                      isLoaded = true;
                    });
                  },
                  child: const Text("Yükle")),
            ),
const Divider(height: 20,color: Colors.black,),
            SizedBox(
                height: 150,
                child: Column(children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: selectedFile.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text("seçilen dosyanın konumu:"),

                              selectedFile.isEmpty
                                  ? const Text("Dosya Yok")
                                  : Card(
                                      elevation: 5,
                                      color: Colors.blueGrey,
                                      child:
                                          Text(selectedFile[index].toString())),
                              //Image.file(selectedFile[index])),
                              isLoaded == true
                                  ? const CircularProgressIndicator()
                                  : const Text("Yükleyebilirsiniz!"),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ])),
            const SizedBox(
              height: 20,
            ),
            //  fileUrl.isEmpty ? const Text("gelen veri yok") :
            const Divider(height: 20, color: Colors.black),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                        child: StreamBuilder(
                      stream: get(),
                      builder: (context, snapshot) {
                        var datam = snapshot.data;

                        return
              snapshot.data == null ? const Center(child: CircularProgressIndicator()) :
                        
                         ListView.builder(
                          itemCount: datam!.docs.length,
                          itemBuilder: (context, index) {
                            var indata = datam.docs[index];
                            //    print("alttakiii ${datam.docs[0].data()}");
                            //  print(indata['isim']);
                            return Slidable(
                              startActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        String pdfView = indata['yazi'];
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PdfViewerPage(pdfView),
                                          ),
                                        );
                                      });
                                    },
                                    backgroundColor: const Color(0xFF21B7CA),
                                    icon: Icons.picture_as_pdf,
                                    label: 'Görüntüle',
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      setState(() {
                                        // doDownloadFile(baseUrl + indata['yazi']);//windowsta calısmaz
                                        // downloadPDF(baseUrl + indata['yazi'], indata['isim']); //windowsta calısır
                                        snackBar2 = const SnackBar(
                                          content: Text("İndiriliyor.."),
                                        );

                                        if (Platform.isWindows) {
                                          downloadPDF(baseUrl + indata['yazi'],
                                              indata['isim']);
                                          downloadPDFloaded == false
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar2)
                                              : const Text("");

                                          print("windows");
                                        } else if (Platform.isAndroid ||
                                            Platform.isIOS) {
                                          //android ios windows
                                          doDownloadFile(
                                              baseUrl + indata['yazi'], indata['isim']);
                                          downloadPDFloaded == false
                                              ? ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar2)
                                              : const Text("");

                                          print("android");
                                        } else {
                                          print("platform desteklenmiyor");
                                        }
                                      });
                                    },
                                    backgroundColor:
                                        const Color.fromARGB(255, 37, 194, 29),
                                    icon: Icons.download,
                                    label: 'indir',
                                  )
                                ],
                              ),
                              //////////////////////////////////
                              endActionPane: ActionPane(
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text("Sil ?"),
                                                content: const Text(
                                                    "Yazınız silinir ve geri getirilemez, emin misiniz?"),
                                                actions: [
                                                  TextButton(
                                                    child: const Text("İptal"),
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                  // vtSil(satirVerisi.id),
                                                  TextButton(
                                                    child: const Text("Sil"),
                                                    onPressed: () => vtSil(
                                                        snapshot.data!
                                                            .docs[index].id),
                                                  ),
                                                ],
                                              ));
                                    },
                                    backgroundColor: const Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Sil',
                                  ),
                                ],
                              ),
                              /////////////
                              child: Card(
                                color: Colors.green,
                                child: ListTile(
                                  title: Text(indata['isim']),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )),
                  ],

                  //Image.network(fileUrl[index])
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> set(
      String koleksiyonAdi, String docu, String text, String dosyaIsim) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final CollectionReference collectionRef =
        firestore.collection(koleksiyonAdi);
    final QuerySnapshot querySnapshot = await collectionRef.get();

    await firestore.collection(koleksiyonAdi).doc(docu).set({
      'yazi': text,
      'isim': dosyaIsim,
    });
    print("setleme başarılı");
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> get() {
    return FirebaseFirestore.instance.collection("assets").snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> future() async {
    return await FirebaseFirestore.instance.collection("assets").get();
  }

  vtSil(String id) {
    var ref = FirebaseFirestore.instance.collection("assets").doc(id).delete();
    Navigator.pop(context);
    print("silindi");
    return ref;
  }

  bool downloading = false;

  /// Display the downloaded percentage value
  String progressString = '';
  double progressString2 = 0;

  /// The path of the image downloaded to the user's phone
  String downloadedImagePath = '';

  /// Get storage premission request from user
  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  /// Get user's phone download directory path
  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  /// Download image and return downloaded image path
  Future downloadFile(String downloadDirectory, String inecekUrl, String dosyaIsim) async {
    Dio dio = Dio();
    var downloadedImagePath = '$downloadDirectory/$dosyaIsim';
    try {
      await dio.download(inecekUrl, downloadedImagePath,
          onReceiveProgress: (rec, total) {
        //      const Duration(seconds: 3);
        /*var snackBar = SnackBar(
  content: Text("REC: $rec" "TOTAL: $total"),
);
ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/
        print("REC: $rec , TOTAL: $total");
        setState(() {
          downloading = true;
          progressString = "${((rec / total) * 100).toStringAsFixed(0)}%";
          progressString2 =
              ((rec / total) * 100).toDouble().toString().codeUnitAt(0) - 48;

          print("aaaaaaaaaaaaaaa $progressString2");
        });
      });
    } catch (e) {
      print(e);
    }

    // Delay to show that the download is complete
    await Future.delayed(const Duration(seconds: 3));

    return downloadedImagePath;
  }

  /// Do download by user's click
  Future<void> doDownloadFile(String inecekUrl, String dosyaIsim) async {
    if (await getStoragePremission()) {
      String downloadDirectory = await getDownloadFolderPath();
      print(downloadDirectory);
      await downloadFile(downloadDirectory, inecekUrl, dosyaIsim).then((imagePath) {
        var snackBar = SnackBar(
          content: Text(
              "İndirme İşlemi Başarılı\n, dosya konumu: $downloadDirectory"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        _diplayImage(imagePath);
      });
    }
  }

  /// Display image after download completed
  void _diplayImage(String downloadDirectory) {
    setState(() {
      downloading = false;
      progressString = "COMPLETED";
      downloadedImagePath = downloadDirectory;
    });
  }
}

class PdfViewerPage extends StatefulWidget {
  final String pdfView;

  const PdfViewerPage(this.pdfView, {super.key});

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String baseUrl = "https://";

  @override
  Widget build(BuildContext context) {
    print(baseUrl + widget.pdfView);
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Dosyası'),
      ),
      body: SfPdfViewer.network(
        baseUrl + widget.pdfView,
        canShowScrollHead: true,
        pageSpacing: 16,
      ),
    );
  }
} //    https://
