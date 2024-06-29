import 'dart:convert';
import 'dart:io';

import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utility/camera.dart';

class Mainmgtscreen extends StatelessWidget {
  void _loginPressed(BuildContext context) {
    print("Login pressed");
    Navigator.pushReplacementNamed(context, '/areasetting');
  }

  void signOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacementNamed(context, '/loging');
  }

  File? image;

  Future _pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      print(image?.name);
      if (image == null) return;

      final imageTemporary = File(image.path);

      File file = File(image.path);
      Uint8List bytes = file.readAsBytesSync();

      String base64Image = base64Encode(bytes);

      print(base64Image);
      print(imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;


    UserPreferences? userPreferences =
        context.watch<AuthProvider>().userPreferences;

    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title: Text(
          'Galaxy Pharma App',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: height * .024),
        ),
        backgroundColor: Colors.greenAccent[400],
        actions: [
          IconButton(
            icon: Text(
              'Sign Out',
              style: TextStyle(
                  color: Colors.red,
                  fontSize: MediaQuery.of(context).size.height * .02,
                  fontWeight: FontWeight.w900),
            ),
            onPressed: () => {
              signOut(context),
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Use SingleChildScrollView
          child: Container(
            margin: EdgeInsets.all(14),
            child: Column(
              children: [
                _header(context),
                SizedBox(height: 20), // Add spacing between sections
                _forgotPassword(context),
                SizedBox(height: 20), // Add spacing between sections
                _signup(context, userPreferences),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: height * .15,
                width: width * .35,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => {Navigator.pushNamed(context, '/salesmgt')},
                  child: Text(
                    "SALES",
                    style: TextStyle(fontSize: height * .024),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Container(
                height: height * .15,
                width: width * .35,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                   onPressed: () => {},
                  child: Text(
                    "PRODUCTION",
                    style: TextStyle(fontSize: height * .022),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                height: height * .15,
                width: width * .35,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text(
                    "ABOUT MOBILE",
                    style: TextStyle(fontSize: height * .024),
                    textAlign: TextAlign.center,
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Container(
                height: height * .15,
                width: width * .35,
                margin: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text("QR Code Scan",
                      style: TextStyle(fontSize: height * .024),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible),
                  style: ElevatedButton.styleFrom(
                    elevation: 3,
                    maximumSize: Size(150, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              )
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

          "Territory:" +
                  user!.teryCode ?? "",
          style: TextStyle(fontSize: MediaQuery.of(context).size.width*.030, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
