import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/addmin/add_quiz.dart';
import 'package:quiz/pages/home.dart';

class AddminLoginPage extends StatefulWidget {
  const AddminLoginPage({super.key});

  @override
  State<AddminLoginPage> createState() => _AddminLoginPageState();
}

class _AddminLoginPageState extends State<AddminLoginPage> {
  // ==================================================================================

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Addmin Login
  void addminLogin() async{
    if(_usernameController.text.isNotEmpty && _passwordController.text.isNotEmpty){
      try {
        await FirebaseFirestore.instance.collection('Addmin').get().then((snapshots){
          snapshots.docs.forEach((snapshot) {
            if(snapshot.data()['id'] != _usernameController.text.trim()){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.amber.shade900,
                content: Text('Your username or password is not correct!'))
              );
            }else if(snapshot.data()['password'] != _passwordController.text.trim()){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.amber.shade900,
                content: Text('Your username or password is not correct!'))
              );
            }else{
              Route route = MaterialPageRoute(builder: (context) => AddQuizPage());
              Navigator.pushReplacement(context, route);
            }
          });
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.amber.shade900,
          content: Text('${e.toString()}'))
        );
      }

    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.amber.shade900,
        content: Text('All fields are required, fill and try again!'))
      );
    };
  }
  // ==================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color(0xFFededeb),
        leading: GestureDetector(
          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage())),
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black38, size: 20.0,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height/1.8,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xFFededeb),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height/2.5,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.4, ),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0))
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 0.0),
                    child: Form(
                      child: Column(
                        children: [
                          Text("Let's Start With Addmin",
                            style: TextStyle(color: Colors.black38, fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 30.0,),
                          Material(
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height/2.2,
                              decoration: BoxDecoration(
                                color: Color(0xFFffffff),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 50.0,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0,),
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _usernameController,
                                        validator: (value) {
                                          if(value == null || value.isEmpty){
                                            return 'Please Enter Username';
                                          }else{
                                            return value;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter Username',
                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          contentPadding: EdgeInsets.all(0.0)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0,),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 15.0,),
                                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5.0)
                                    ),
                                    child: Center(
                                      child: TextFormField(
                                        controller: _passwordController,
                                        validator: (value) {
                                          if(value == null || value.isEmpty){
                                            return 'Please Enter Password';
                                          }else{
                                            return value;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Enter Password',
                                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          contentPadding: EdgeInsets.all(0.0)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0,),
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        addminLogin();
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 15.0),
                                      margin: EdgeInsets.symmetric(horizontal:20.0 ),
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: Center(
                                        child: Text('LOGIN',
                                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
                                      ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}