import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:quiz/addmin/admin_login.dart';
import 'package:quiz/services/database.dart';
import 'package:random_string/random_string.dart';

class AddQuizPage extends StatefulWidget {
  const AddQuizPage({super.key});

  @override
  State<AddQuizPage> createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {

  // =========================================================================================

  // Text field controllers
  final TextEditingController _optionController1 = TextEditingController();
  final TextEditingController _optionController2 = TextEditingController();
  final TextEditingController _optionController3 = TextEditingController();
  final TextEditingController _optionController4 = TextEditingController();
  final TextEditingController _correctAnswerController = TextEditingController();

  // Catagory lists
  String? categoryValue;
  final List<String> quizItems = ['Animal', 'Fruit', 'Place', 'Object', 'Random', 'Sport'];

  // Image picker
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future getImage() async{
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
  }

  // Upload files
  void uploadFile() async{
    if(selectedImage != null && _optionController1.text != '' && _optionController2.text != '' && _optionController3.text != '' && _optionController4.text != '' && _correctAnswerController.text != '' ){

      String addID = randomAlphaNumeric(10);
      Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('qizImage').child(addID);

      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);
      var downloadUrl = await(await task).ref.getDownloadURL();

      Map<String, dynamic> addQuiz = {
        "image": downloadUrl,
        'option1': _optionController1.text,
        'option2': _optionController2.text,
        'option3': _optionController3.text,
        'option4': _optionController4.text,
        'correct': _correctAnswerController.text,
      };
      await DatabaseMethods().addQuizCategory(addQuiz, categoryValue!).then((value){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.orange.shade900,
          content: Text('Quiz has been added Successfully!', style: TextStyle(color: Colors.white),)
        ));
      });
      _optionController1.clear();
      _optionController2.clear();
      _optionController3.clear();
      _optionController4.clear();
      _correctAnswerController.clear();
      setState(() {
        categoryValue = null;
        selectedImage = null;
      });
    }
  }


  // ========================================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade800,
        title: Text('Add Quiz',
        style: TextStyle(color: Color(0xFFeeeeee), fontWeight: FontWeight.bold, fontSize: 25.0),),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddminLoginPage())),
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white, size: 20.0,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Upload the Quiz Picture',
              style: TextStyle(color: Color(0xFF000000), fontWeight: FontWeight.bold, fontSize: 17.0),),
              SizedBox(height: 20.0,),

              selectedImage == null ? GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade600, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Icon(Icons.camera_alt_outlined, color: Colors.black,),
                    ),
                  ),
                ),
              ) : Center(
                  child: Material(
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade600, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.cover,
                        ),
                      )
                      // Icon(Icons.camera_alt_outlined, color: Colors.black,),
                    ),
                  ),
                ),

        
              SizedBox(height: 15.0,),
              
              Text('Option 1', style: TextStyle(color: Colors.black, fontSize: 15.0),),
              SizedBox(height: 4.0),
              CupertinoTextField(
                controller: _optionController1,
                cursorWidth: 1.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                placeholder: 'Enter option 1',
                placeholderStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
                style: TextStyle(fontSize: 14.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
                    
              SizedBox(height: 10.0),

              Text('Option 2', style: TextStyle(color: Colors.black, fontSize: 15.0),),
              SizedBox(height: 4.0),
              CupertinoTextField(
                controller: _optionController2,
                cursorWidth: 1.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                placeholder: 'Enter option 2',
                placeholderStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
                style: TextStyle(fontSize: 14.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),

              SizedBox(height: 10.0,),
              
              Text('Option 3', style: TextStyle(color: Colors.black, fontSize: 15.0),),
              SizedBox(height: 4.0),
              CupertinoTextField(
                controller: _optionController3,
                cursorWidth: 1.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                placeholder: 'Enter option 3',
                placeholderStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
                style: TextStyle(fontSize: 14.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
                    
              SizedBox(height: 10.0),

              Text('Option 4', style: TextStyle(color: Colors.black, fontSize: 15.0),),
              SizedBox(height: 4.0,),
              CupertinoTextField(
                controller: _optionController4,
                cursorWidth: 1.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                placeholder: 'Enter option 4',
                placeholderStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
                style: TextStyle(fontSize: 14.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),
                             
              SizedBox(height: 15.0),

              Text('* Correct Answer', style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),),
              SizedBox(height: 4.0,),
              CupertinoTextField(
                controller: _correctAnswerController,
                cursorWidth: 1.0,
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
                placeholder: 'Enter the correct answer',
                placeholderStyle: TextStyle(fontSize: 14.0, color: Colors.grey.shade500),
                style: TextStyle(fontSize: 14.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(5.0)
                ),
              ),

              SizedBox(height: 15.0),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFececf8),
                  borderRadius: BorderRadius.circular(10.0)
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items: quizItems.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(item, style: TextStyle(color: Colors.blue, fontSize: 14.0),))).toList(), 
                    onChanged: ((value) => setState(() {
                      this.categoryValue = value;
                    })),
                    dropdownColor: Colors.white,
                    hint: Text('Select category', style: TextStyle(fontSize: 14, color: Colors.blue),),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black,),
                    value: categoryValue,
                  ),
                ),
              ),

              SizedBox(height: 10.0,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    uploadFile();
                  });
                },
                child: Center(
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: EdgeInsets.all(7.0),
                      width: 150.0,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Center(
                        child: Text('Add', 
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}