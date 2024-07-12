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
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height * .017),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * .05,
              child: TextFormField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * .017),
                readOnly: title == 'User Id' ? true : false,
                controller: controller,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                onChanged: (text) {
                  TextSelection previousSelection = controller.selection;
                  controller.text = text;
                  controller.selection = previousSelection;
                },
                decoration: InputDecoration(
                  hintText: hint,
                  enabledBorder: const UnderlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
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
  final bool obscureText;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    required this.title,
    this.obscureText = false,
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
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: MediaQuery.of(context).size.height * .017),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              height: MediaQuery.of(context).size.height * .05,
              child: TextFormField(
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * .02),
                readOnly: title == 'User Id' ? true : false,
                obscureText: this.obscureText,
                controller: controller,
                onChanged: (text) {
                  TextSelection previousSelection = controller.selection;
                  controller.text = text;
                  controller.selection = previousSelection;
                },
                decoration: InputDecoration(
                    hintText: hint,
                    enabledBorder: const UnderlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)))),
              ),
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:
                                MediaQuery.of(context).size.height * .017),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .017),
                      readOnly: !isEnable,
                      controller: controller,
                      onChanged: (text) {
                        TextSelection previousSelection = controller.selection;
                        controller.text = text;
                        controller.selection = previousSelection;
                      },
                      decoration: InputDecoration(
                        hintText: hint,
                        enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
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
  final bool visibility;

  const TextFeildWithSearchBtn(
      {super.key,
      required this.controller,
      required this.hint,
      required this.title,
      required this.onPressed,
      required this.isEnable,
      this.visibility = true});

  @override
  Widget build(BuildContext context) {
    return visibility
        ? Container(
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
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:
                                MediaQuery.of(context).size.height * .017),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .017),
                      readOnly: !isEnable,
                      controller: controller,
                      onChanged: (text) {
                        TextSelection previousSelection = controller.selection;
                        controller.text = text;
                        controller.selection = previousSelection;
                      },
                      decoration: InputDecoration(
                          hintText: hint,
                          enabledBorder: const UnderlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)))),
                    ),
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
          )
        : SizedBox.shrink();
    ;
  }
}

class CustomTextFormfieldTwoColumn extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String hint1;
  final String hint2;
  final String title1;
  final String title2;
  final TextInputType? keyboardType;
  final bool visibility;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFormfieldTwoColumn({
    super.key,
    required this.controller1,
    required this.hint1,
    required this.title1,
    required this.controller2,
    required this.hint2,
    required this.title2,
    this.keyboardType,
    this.visibility = true,
    this.inputFormatters,
  });

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
                        title1,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:
                                MediaQuery.of(context).size.height * .017),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    height: MediaQuery.of(context).size.height * .05,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .017),
                      readOnly: title1 == 'User Id' ? true : false,
                      controller: controller1,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      onChanged: (text) {
                        TextSelection previousSelection = controller1.selection;
                        controller1.text = text;
                        controller1.selection = previousSelection;
                      },
                      decoration: InputDecoration(
                        hintText: hint1,
                        enabledBorder: const UnderlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title2,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize:
                                MediaQuery.of(context).size.height * .017),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    child: TextFormField(
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .017),
                      readOnly: title2 == 'User Id' ? true : false,
                      controller: controller2,
                      keyboardType: keyboardType,
                      inputFormatters: inputFormatters,
                      onChanged: (text) {
                        TextSelection previousSelection = controller2.selection;
                        controller2.text = text;
                        controller2.selection = previousSelection;
                      },
                      decoration: InputDecoration(
                        hintText: hint2,
                        enabledBorder: const UnderlineInputBorder(
                            // borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox.shrink();
    ;
  }
}

class CustomTextFormfieldTwoColumnWithSearchBtn extends StatelessWidget {
  final TextEditingController controller1;
  final TextEditingController controller2;
  final String hint1;
  final String hint2;
  final String title1;
  final String title2;
  final TextInputType? keyboardType;
  final bool visibility;
  final List<TextInputFormatter>? inputFormatters;
  final VoidCallback onPressed;
  final IsEnable;
  final ShowButton;

  const CustomTextFormfieldTwoColumnWithSearchBtn(
      {super.key,
      required this.controller1,
      required this.hint1,
      required this.title1,
      required this.controller2,
      required this.hint2,
      required this.title2,
      this.keyboardType,
      this.visibility = true,
      this.inputFormatters,
      required this.onPressed,
      this.IsEnable = true,
      this.ShowButton = true});

  @override
  Widget build(BuildContext context) {
    if (visibility) {
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
                    title1,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: MediaQuery.of(context).size.height * .017),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(right: 5),
                height: MediaQuery.of(context).size.height * .05,
                child: TextFormField(
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .017),
                  readOnly: IsEnable,
                  controller: controller1,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  onChanged: (text) {
                    TextSelection previousSelection = controller1.selection;
                    controller1.text = text;
                    controller1.selection = previousSelection;
                  },
                  decoration: InputDecoration(
                    hintText: hint1,
                    enabledBorder: const UnderlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                height: MediaQuery.of(context).size.height * .05,
                child: TextFormField(
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .017),
                  readOnly: IsEnable,
                  controller: controller2,
                  keyboardType: keyboardType,
                  inputFormatters: inputFormatters,
                  onChanged: (text) {
                    TextSelection previousSelection = controller2.selection;
                    controller2.text = text;
                    controller2.selection = previousSelection;
                  },
                  decoration: InputDecoration(
                    hintText: hint2,
                    enabledBorder: const UnderlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                  ),
                ),
              ),
            ),
            ShowButton
                ? Expanded(
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
                : SizedBox.shrink()
          ],
        ),
      );
    } else {
      return SizedBox.shrink();
    }
    ;
  }
}
