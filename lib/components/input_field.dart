import 'package: flutter/material.dart';
import 'package: electa/utils/app_colors.dart';

class InputField extends StatelessWidget {
  const InputField({super.key, required this.controller, required this.hintText, this.icon, this.disable=false, this.hideText= false, this.validator});

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final bool disable;
  final bool hideText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.only(top: 10.0, bottom: 5, left: 10, right: 10),
      child: Stack(

        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(50.0)
            ),
            child: Icon(icon, size: 40, color: whiteColor,),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            readOnly: disable,
            controller: controller,
            validator: validator,
            obscureText: hideText,
            autoFocus: true,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 70.0, vertical: 20),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: primaryColor, width: 1)
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: primaryColor, width: 2)
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: primaryColor, width:1)
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: BorderSide(color: Colors.red, width: 2)
              )


            ),
          ),
        ]
      ),
    );
  }
}
