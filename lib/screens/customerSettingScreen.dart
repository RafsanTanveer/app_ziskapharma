import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:flutter/material.dart';

class CustomerSettingScreen extends StatelessWidget {
  const CustomerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController typeNameController = TextEditingController();
    TextEditingController territoryCodeController = TextEditingController();
    TextEditingController territoryNameController = TextEditingController();
    TextEditingController customerNameController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController mobileController = TextEditingController();
    TextEditingController categoryCodeController = TextEditingController();
    TextEditingController categoryNameController = TextEditingController();
    TextEditingController refCodeController = TextEditingController();
    TextEditingController refNameController = TextEditingController();
    TextEditingController rulesNoController = TextEditingController();
    TextEditingController rulesNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Customer Information Settings',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.height * .022),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SafeArea(
        child: Scrollbar(
          thumbVisibility: true,
          thickness: 15,
          interactive: true,
          radius: Radius.circular(20),
          child: Container(
            margin: EdgeInsets.only(top: 20.0, left: 15, right: 25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextFormField(
                      controller: typeNameController,
                      hint: "hint",
                      title: "Type Name"),
                  CustomTextFormField(
                      controller: territoryCodeController,
                      hint: 'hint',
                      title: "Territory Code"),
                  CustomTextFormField(
                      controller: territoryNameController,
                      hint: "hint",
                      title: "Territory Name"),
                  CustomTextFormField(
                      controller: customerNameController,
                      hint: "hint",
                      title: "Customer Name"),
                  CustomTextFormField(
                      controller: addressController,
                      hint: 'hint',
                      title: "Address *"),
                  CustomTextFormField(
                      controller: mobileController,
                      hint: 'hint',
                      title: "Mobile *"),
                  CustomTextFormField(
                      controller: categoryCodeController,
                      hint: 'hint',
                      title: "Category Code"),
                  CustomTextFormField(
                      controller: categoryNameController,
                      hint: 'hint',
                      title: "Category Name"),
                  CustomTextFormField(
                      controller: refCodeController,
                      hint: 'hint',
                      title: "Ref. Code"),
                  CustomTextFormField(
                      controller: refNameController,
                      hint: 'hint',
                      title: "Ref. Name"),
                  CustomTextFormField(
                      controller: rulesNoController,
                      hint: 'hint',
                      title: "Rules No."),
                  CustomTextFormField(
                      controller: rulesNameController,
                      hint: 'hint',
                      title: "Rules Name."),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                elevation: 3,
                                maximumSize: Size(150, 150),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(12), // <-- Radius
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                              ),
                              onPressed: () => {},
                              child: Text(
                                'SENT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            .020),
                              ))),
                      Container(
                        margin: EdgeInsets.all(10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              elevation: 3,
                              maximumSize: Size(150, 150),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12), // <-- Radius
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                            ),
                            onPressed: () =>
                                {Navigator.pop(context, '/salesmgt')},
                            child: Text(
                              'BACK',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: MediaQuery.of(context).size.height *
                                      .020),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}
