import 'package:flutter/material.dart';

class Textfield extends StatelessWidget {
  final String text;
  final Widget? icon;
  final TextEditingController? controller;
  const Textfield(
      {super.key, required this.text, required this.icon, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: text,
        fillColor: const Color(0xffEDEDED),
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Color(0xffEDEDED),
          ),
        ),
        contentPadding: const EdgeInsets.all(17.0),
        prefixIcon: icon,
      ),
    );
  }
}
