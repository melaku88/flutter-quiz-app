import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz/components/choices.dart';
import 'package:quiz/pages/home.dart';
import 'package:quiz/services/database.dart';

class QuestionPage extends StatefulWidget {

  final String category;
 const QuestionPage({super.key, required this.category});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  // =============================================================================
  bool show = false;
  Stream? quizeStream;
  final PageController _pageController = PageController();

  getOnTheLoad() async{
    quizeStream = await DatabaseMethods().getQuizCategory(widget.category);
    setState(() {
      
    });
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allQuiz(){
    return StreamBuilder(
      stream: quizeStream, 
      builder: (context, AsyncSnapshot snapshot){
        return snapshot.hasData ? PageView.builder(
          controller: _pageController,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot ds = snapshot.data!.docs[index];

            return Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xFFeeeeee),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(ds['image'], height: 250.0, width: MediaQuery.of(context).size.width, fit: BoxFit.cover,)
                    ),

                    GestureDetector(
                      onTap: () {
                        show = true;
                        setState(() {
                        });
                      },
                      child: show ? 
                        MyChoiceContainer(text: ds['option1'], color: ds['correct'] == ds['option1'] ?  Colors.green.shade400 : Colors.red.shade200) 
                        : 
                        MyChoiceContainer(text: ds['option1'], color: Colors.white,),
                    ),

                    GestureDetector(
                      onTap: () {
                        show = true;
                        setState(() {
                        });
                      },
                      child: show ? 
                        MyChoiceContainer(text: ds['option2'], color: ds['correct'] == ds['option2'] ?  Colors.green.shade400 : Colors.red.shade200) 
                        : 
                        MyChoiceContainer(text: ds['option2'], color: Colors.white,)
                    ),

                    GestureDetector(
                      onTap: () {
                        bool show = false;
                        setState(() {
                          show = !show;
                        });
                      },
                      child: show ? 
                        MyChoiceContainer(text: ds['option3'], color: ds['correct'] == ds['option3'] ?  Colors.green.shade400 : Colors.red.shade200) 
                        : 
                        MyChoiceContainer(text: ds['option3'], color: Colors.white,)
                    ),
                    
                    GestureDetector(
                      onTap: () {
                        show = true;
                        setState(() {
                        });
                      },
                      child: show ? 
                        MyChoiceContainer(text: ds['option4'], color: ds['correct'] == ds['option4'] ?  Colors.green.shade400 : Colors.red.shade200) 
                        : 
                        MyChoiceContainer(text: ds['option4'], color: Colors.white,)
                    ),

                    GestureDetector(
                      onTap:() {
                        _pageController.nextPage(duration: Duration(milliseconds: 200), curve: Curves.easeIn);
                      },
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        margin: EdgeInsets.only(top: 5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade700),
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Icon(Icons.arrow_forward_ios_outlined, color: Color(0xFF004840), size: 20.0,)
                      ),
                    ),
                  
                  ],
                ),
              ),
            );
          }
        ) : Container();
      }
    );
  }
  // =============================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF004840),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.grey.shade200, size: 22.0,),
                  ),
                  SizedBox(width: 100.0,),
                  Text(widget.category,
                    style: TextStyle(color: Color(0xFFeeeeee), fontSize: 22.0, fontWeight: FontWeight.bold, fontFamily: 'Elsie'),
                  )
                ],
              ),
            ),
            SizedBox(height: 20.0,),

            Expanded(
              child: allQuiz(),
            )
          ],
        ),
      ),
    );
  }
}