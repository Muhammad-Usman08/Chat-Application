import 'package:flutter/material.dart';

Widget button(String buttonText, double width, double height) {
  return (Container(
    margin: const EdgeInsets.only(top: 100),
    width: width,
    height: height,
    child: ElevatedButton(
        onPressed: () {},
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
