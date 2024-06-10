import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyChoiceContainer extends StatelessWidget {
  final String text;
  final Color color;
  const MyChoiceContainer({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(10.0),
        color:color,
      ),
      child: Text(text,
        style: TextStyle(color: Colors.black, fontSize: 15.0, fontFamily: 'Elsie'),
      ),
    );
  }
}