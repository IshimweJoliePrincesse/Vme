import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.tap, required this.text, required this.color, this.height= 60, this.fontColor, this.fontSize, this.borderRadius = 0, this.loading = false});

  final String text;
  final Color color;
  final Color? fontColor;
  final double? fontSize;
  final double borderRadius;
  final double height;
  final VoidCallback tap;
  final bool loading;

  @override
  Widget build (BuildContext contect){
    return SizedBox(
      width: double.infinity,
      height: height,

      child: ElevatedButton(style: ElevatedButton.styleFrom(foregroundColor: Colors.white, backgroundColor: color, shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(borderRadius)), minimumSize: Size.fromHeight(height)), onPressed: tap, child: loading ? const Row( mainAxisAlignment: MainAxisAlignment.center, children: [CupertinoActivityIndicator(color: Colors.white, radius: 12,), SizedBox(width: 10,),  Text('Please Wait...')], ): Text(text.toUpperCase(), style: TextStyle(color: fontColor, fontSize: fontSize),))
    );
  }
}