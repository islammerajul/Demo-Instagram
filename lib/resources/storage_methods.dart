import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // adding image to Firebase Storage
  // This method will be used for both to store Profile Pic and also store posts.
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    // Check is it posted or not by isPost property. If post then check for extra functionalities.
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    // Using "Uint8List" it takes putData()
    UploadTask uploadTask = ref.putData(file);
    // you can upload in Firebase "Storage"
    TaskSnapshot snap = await uploadTask;

    //From storage, you can download profile picture or something which are stored in storage
    //When you upload an image in Storage, you get a token againts the image.
    //"snap.ref.getDownloadUrl()" will be able to get an URL which will store this FireStore Database over here.
    // So that we can access with the network image and display it of all the Users. 
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
