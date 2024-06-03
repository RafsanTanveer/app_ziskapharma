import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;

  const CustomTextFormField(
      {super.key,
      required this.controller,
      required this.hint,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            onChanged: (text) {
              // Update the text in the controller when the text field changes
              controller?.text = text;
              print(text);
            },
            decoration: InputDecoration(
                hintText: hint, enabledBorder: const OutlineInputBorder()),
          ),
        ),
      ],
    );
    ;
  }
}
