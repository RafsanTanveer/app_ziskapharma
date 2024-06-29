import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Salesmgtscreen extends StatelessWidget {
  void _loginPressed(BuildContext context) {
    print("Login pressed");
    Navigator.pushReplacementNamed(context, '/areasetting');
  }

  @override
  Widget build(BuildContext context) {


    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    return Scaffold(
      // drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          'Galaxy Pharma App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.greenAccent[400],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(14),
          child: Column(
            children: [
              _header(context),
              // _inputField(context),
              _forgotPassword(context),
              _signup(context, userPreferences),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () => {Navigator.pushNamed(context, '/userinfo')},
                  child: Text(
                    "USER INFO CHANGE",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/areasetting')},
                  child: Text(
                    "DEFAULT TERRITORY",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/cutomergrouplist')},
                  child: Text(
                    "CUSTOMER LIST",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/cutomergrouplistforsales')
                  },
                  child: Text("SALES ORDER ONCO",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .022),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/cutomergrouplistforsetting')
                  },
                  child: Text(
                    "CUSTOMER SETTINGS",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text("SALES ORDER ONCO LIST",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * .022),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/slsinvview')},
                  child: Text(
                    "INVOICE APPROVAL",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * .12,
                width: MediaQuery.of(context).size.width * .4,
                margin: const EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () =>
                      {Navigator.pushNamed(
                context,
                '/customerlist',
                arguments: CustomerSettingScreenArgs(
                    '03', 'doctor', ''),
              )},
                  child: Text(
                    "DOCTORS LIST",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _forgotPassword(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/ziskaPharmaIcon.png',
          height: 100,
          width: 100,
        ),
        Text(
          'Ziska Pharmaceuticals Ltd.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _signup(context, UserPreferences? user) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
             user!.userFullName ?? "",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width * .040, fontWeight: FontWeight.w500),
        ),
        Text(
          "Territory:" + user.teryCode! ?? "",
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * .030,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
