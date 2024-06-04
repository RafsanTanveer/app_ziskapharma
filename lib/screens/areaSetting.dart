import 'package:app_ziskapharma/custom_widgets/textFormField.dart';
import 'package:flutter/material.dart';

class Areasetting extends StatelessWidget {
  const Areasetting({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController territoryCodeController = TextEditingController();
    TextEditingController territoryNameController = TextEditingController();
    TextEditingController areaCodeController = TextEditingController();
    TextEditingController areaNameController = TextEditingController();
    TextEditingController regionCodeController = TextEditingController();
    TextEditingController regionNameController = TextEditingController();
    TextEditingController depotCodeController = TextEditingController();
    TextEditingController depotNameController = TextEditingController();
    TextEditingController userIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User-wise Area Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
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
                      controller: territoryCodeController,
                      hint: 'hint',
                      title: "Territory Code"),
                  CustomTextFormField(
                      controller: territoryNameController,
                      hint: 'hint',
                      title: "Territory Name"),
                  CustomTextFormField(
                      controller: areaCodeController,
                      hint: 'hint',
                      title: "Area Code"),
                  CustomTextFormField(
                      controller: areaNameController,
                      hint: 'hint',
                      title: "Area Name"),
                  CustomTextFormField(
                      controller: regionCodeController,
                      hint: "Region Code",
                      title: "Region Code"),
                  CustomTextFormField(
                      controller: regionNameController,
                      hint: "Region Name",
                      title: "Region Name"),
                  CustomTextFormField(
                      controller: depotCodeController,
                      hint: "Depot Code",
                      title: "Depot Code"),
                  CustomTextFormField(
                      controller: depotNameController,
                      hint: "Depot Name",
                      title: "Depot Name"),
                  CustomTextFormField(
                      controller: userIdController,
                      hint: "User Id",
                      title: "User Id"),
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
                                'Save',
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
                              'Close',
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
