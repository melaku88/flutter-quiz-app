import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCategoryContainer extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String img;
  const MyCategoryContainer({
    super.key,
    required this.onTap,
    required this.text,
    required this.img
    });

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 2.0,
        child: Container(
          width: 100.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: Column(
            children: [
              Image.asset(img, height: 65.0, width: 65.0, fit: BoxFit.cover,),
              SizedBox(height: 20.0,),
              Text(text, style: TextStyle(fontFamily: 'Elsie'),)
            ],
          ),
        ),
      ),
    );
  }
}