import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddminLoginPage extends StatefulWidget {
  const AddminLoginPage({super.key});

  @override
  State<AddminLoginPage> createState() => _AddminLoginPageState();
}

class _AddminLoginPageState extends State<AddminLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFFededeb),
      backgroundColor: Colors.green.shade900,
      body: Container(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.9),
              padding: EdgeInsets.only(top: 45.0, right: 20.0,left: 20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                ),
                borderRadius: BorderRadius.vertical(top: Radius.elliptical(MediaQuery.of(context).size.width, 110.0))
              ),
            )
          ],
        ),
      ),
    );
  }
}