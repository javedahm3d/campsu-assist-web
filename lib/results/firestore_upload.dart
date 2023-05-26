import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseResultStorageClass {
  final FirebaseStorage storage = FirebaseStorage.instance;
  // final currentUser = FirebaseAuth.instance.currentUser!.uid;

  Future<String> uploadFile(Uint8List file, String sem, String dept,
      String fileName, String RC) async {
    // File file = File(filePath);

    TaskSnapshot snap =
        await storage.ref('results/$sem/$dept/$fileName').putData(file);

    String downloadUrl = await snap.ref.getDownloadURL();
    print(downloadUrl);

    return downloadUrl;
  }
}
