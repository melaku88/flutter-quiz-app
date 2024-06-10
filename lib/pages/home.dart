import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz/addmin/admin_login.dart';
import 'package:quiz/components/category.dart';
import 'package:quiz/pages/question.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffedf3f6),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Column(
            children: [
              Container(
                height: 230.0,
                padding: EdgeInsets.fromLTRB(20.0, 50.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2a2b31),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.elliptical(MediaQuery.of(context).size.width, 100)
                  )
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset('images/meaza.png', height: 60, width: 60, fit: BoxFit.cover,),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Text('Meaza Aderaw', 
                                style: TextStyle(color: Color(0xFFeeeeee), fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'IndieFlower'),
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddminLoginPage())),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Admin', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                                Icon(Icons.arrow_drop_down, color: Colors.green, size: 30.0,),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 40.0,),
                    Text(
                      'Play & Win',
                      style: TextStyle(
                        fontSize: 20.0, color: Colors.orange, 
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Elsie'),
                    ),
                    Text(
                      'Play the quiz by gussing the images',
                      style: TextStyle(
                        fontSize: 15.0, color: Colors.orange, 
                        fontStyle: FontStyle.italic,
                        fontFamily: 'IndieFlower'),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0,),
        
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Top Quiz Categories', 
                  style: TextStyle(color: Color(0xFF2a2b31), fontSize: 20.0, fontWeight: FontWeight.bold, fontFamily: 'Elsie'),
                ),
              ),
        
              SizedBox(height: 15.0,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              
                  MyCategoryContainer(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(category: 'Place')));
                    }, 
                    text: 'Places', 
                    img: 'images/place.png'
                  ),
              
                  MyCategoryContainer(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(category: 'Animal')));
                    }, 
                    text: 'Animals', 
                    img: 'images/animal.png'
                  ),

                  MyCategoryContainer(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(category: 'Fruit')));
                    }, 
                    text: 'Fruits', 
                    img: 'images/fruit.png'
                  ),
                ],
              ),
        
              SizedBox(height: 30.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  
                  MyCategoryContainer(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(category: 'Sport')));
                    }, 
                    text: 'Sports', 
                    img: 'images/sports.png'
                  ),
                  
                  MyCategoryContainer(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(category: 'Object')));
                    }, 
                    text: 'Objects', 
                    img: 'images/object.png'
                  ),
              
                  MyCategoryContainer(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionPage(category: 'Random')));
                    }, 
                    text: 'Randoms', 
                    img: 'images/random.png'
                  ),
                ],
              )
          
            ],
          ),
        ),
      ),
    );
  }
}