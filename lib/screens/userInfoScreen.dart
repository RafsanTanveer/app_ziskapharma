import 'package:flutter/material.dart';

class Userinfoscreen extends StatelessWidget {
  const Userinfoscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Info Edit',
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
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/person.png',
                      ),
                      
                    ],
                  ),
                  textFeild("User Id", "User Id"),
                  textFeild("Password", "Password"),
                  textFeild("Full Name", "Full Name"),
                  textFeild("Designation", "Designation"),
                  textFeild("Mobile no.", "Mobile no."),
                  textFeild("Email", "Email"),
                  textFeild("Department Code", "Department Code"),
                  textFeild("Department Name", "Department Name"),
                  textFeild("Branch Code", "Branch Code"),
                  textFeild("Branch Name", "Branch Name"),
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
                                'Submit',
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
                              'Cancel',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: MediaQuery.of(context).size.height*.020),
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

  Widget textFeild(String hint, String title) {
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
            decoration: InputDecoration(
                hintText: hint, enabledBorder: const OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
