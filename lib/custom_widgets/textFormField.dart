import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWithFormatter extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormFieldWithFormatter({
    super.key,
    required this.controller,
    required this.hint,
    required this.title,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              readOnly: title == 'User Id' ? true : false,
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              onChanged: (text) {
                // Update the text in the controller when the text field changes
                controller.text = text;
                print(text);
              },
              decoration: InputDecoration(
                hintText: hint,
                enabledBorder: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: TextFormField(
              readOnly: title == 'User Id' ? true : false,
              controller: controller,
              onChanged: (text) {
                // Update the text in the controller when the text field changes
                controller?.text = text;
                print(text);
              },
              decoration: InputDecoration(
                  hintText: hint,
                  enabledBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          ),
        ],
      ),
    );
    ;
  }
}

class CustomTextFormFieldAreaSetting extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final bool isEnable;
  final bool visibility;

  const CustomTextFormFieldAreaSetting(
      {super.key,
      required this.controller,
      required this.hint,
      required this.title,
      required this.isEnable,
      this.visibility = true}); // Default visibility is true

  @override
  Widget build(BuildContext context) {
    return visibility
        ? Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    readOnly: !isEnable,
                    controller: controller,
                    onChanged: (text) {
                      // Update the text in the controller when the text field changes
                      controller.text = text;
                      print(text);
                    },
                    decoration: InputDecoration(
                      hintText: hint,
                      enabledBorder: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink(); // Return an empty widget when not visible
  }
}

List<DropdownMenuItem<String>> addDividersAfterItems(
    List<String> items, String selectedValue) {
  List<DropdownMenuItem<String>> _menuItems = [];
  for (var item in items) {
    _menuItems.addAll(
      [
        DropdownMenuItem<String>(
          value: item,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(item,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight:
                      selectedValue == item ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 16,
                )),
          ),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<String>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return _menuItems;
}

class TextFeildWithSearchBtn extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String title;
  final VoidCallback onPressed;
  final bool isEnable;

  const TextFeildWithSearchBtn(
      {super.key,
      required this.controller,
      required this.hint,
      required this.title,
      required this.onPressed,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: TextFormField(
              readOnly: !isEnable,
              controller: controller,
              onChanged: (text) {
                // Update the text in the controller when the text field changes
                controller?.text = text;
                print(text);
              },
              decoration: InputDecoration(
                  hintText: hint,
                  enabledBorder: const UnderlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(right: 1, left: 5),
                child: Material(
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: IconButton(
                      onPressed: () => onPressed(),
                      icon: const Icon(Icons.search)),
                ),
              ))
        ],
      ),
    );
    ;
  }
}
