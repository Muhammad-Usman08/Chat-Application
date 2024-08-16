import 'package:flutter/material.dart';

Widget button(String buttonText, double width, double height,
    void Function()? onpressed) {
  return (SizedBox(
    width: width,
    height: height,
    child: ElevatedButton(
        onPressed: onpressed,
        style: const ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Color(0xffEC2578)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        )),
  ));
}
