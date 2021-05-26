import 'package:flutter/material.dart';

import '../constaint.dart';

class Text_field extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function validate;
  final Function onClick;

  TextEditingController controller;

  TextInputType type;

  Text_field({
    @required this.hint,
    this.icon,
    this.validate,
    @required this.onClick,
    this.controller,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        controller: controller,
        onSaved: onClick,
        keyboardType: type,
        validator: validate,
        cursorColor: kmainColor,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: kmainColor,
          ),
          filled: true,
          fillColor: ksecondColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white)),
        ),
      ),
    );
  }
}
