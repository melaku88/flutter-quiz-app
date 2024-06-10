import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  // =========================================================================================

  // first declar for the variable image
  File? selectedImage;

  // second get the image from the gallery or cammera
  Future getImage() async{
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
  }

  // now lets upload the image to firebase storage and firebase firestore
  void uploadImage() async{
    if(selectedImage != null){
      String imageID = randomAlphaNumeric(10);

      Reference storageReferance = await FirebaseStorage.instance.ref().child('testImages').child(imageID);

      final UploadTask task = storageReferance.putFile(selectedImage!);
      var downloadUrl = await (await task).ref.getDownloadURL();

      await FirebaseFirestore.instance
        .collection('category')
        .add({
          'image': downloadUrl,
        });
    }
  }

  // =========================================================================================
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}