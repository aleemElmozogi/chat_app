import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.title,
    required this.myController,
  }) : super(key: key);
  final String title;
  final TextEditingController myController;
  // final Function onChange;
  //
  // void changeTex(val) {
  //   onChange(val);
  // }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: myController,
      // onChanged: changeTex,
      decoration: InputDecoration(
        hintText: title,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 1.0),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple.shade800, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
    );
  }
}
