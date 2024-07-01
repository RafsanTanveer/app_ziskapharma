import 'dart:convert';

import 'package:app_ziskapharma/model/UserModel.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/model/sample.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../dataaccess/apiAccess.dart' as apiAccess;
import 'package:shared_preferences/shared_preferences.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final userTxtCntrl = TextEditingController();
  final passTxtCntrl = TextEditingController();


  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void setData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final String userUID = await prefs.getString('userUID') ?? '';
    final String userPws = await prefs.getString('userPws') ?? '';

    context.read<AuthProvider>().setUserId(userUID);
    context.read<AuthProvider>().setUserPass(userPws);

    final loginUrl = Uri.parse(
        '${apiAccess.apiBaseUrl}/LogIn/ProcessTableCompanyInfo?user_UID=${userUID}');

    final response = await http.get(loginUrl);

    Map<String, dynamic> jsonResponse = json.decode(response.body);

    // Assuming the list you need is under a key 'data' or similar
    var table = jsonResponse['Table'][0];
    var table1 = jsonResponse['Table1'][0];

    UserModel user = UserModel.fromJson(table);
    UserPreferences userPreferences = UserPreferences.fromJson(table1);
    print(userPreferences.userBrnID);
    // Update the provider
    context.read<AuthProvider>().setUser(user);
    context.read<AuthProvider>().setUserPreferences(userPreferences);


    //provider.user_id
  }

  void isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var flag = prefs.getBool('isLoggedIn');
    var flag2 = prefs.getBool('isLoggedIn');
    print(prefs.getBool('isLoggedIn'));

    if (await prefs.getBool('isLoggedIn') ?? false) {
      //////////////////////////////////////////////////////////////

      setData(context);

      //////////////////////////////////////////////////////////////

      await Future.delayed(Duration(milliseconds: 1500), () {});
      Navigator.pushReplacementNamed(context, '/mainmgt');
    }
  }

  void initState() {
    super.initState();
    isLoggedIn();
  }

  @override
  void dispose() {
    userTxtCntrl.dispose();
    passTxtCntrl.dispose();
    super.dispose();
  }

  void _loginPressed(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);

    final String userUID = userTxtCntrl.text;
    final String userPws = passTxtCntrl.text;

    @override
    final body = json.encode({
      "Table1": [
        {"user_UID": userUID, "user_Pws": userPws}
      ]
    });

    try {
      final url = Uri.parse(
          '${apiAccess.apiBaseUrl}/LogIn/Proc_UserCheckYesNoByApiDataSet');

      final response = await http.post(
        url,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Access-Control-Allow-Credentials": 'true',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Content-Type": "application/json",
          "Access-Control-Allow-Methods": "POST, OPTIONS"
        },
        body: body,
      );

      final responseData = await json.decode(json.encode(response.body));
      if (responseData == 'true') {
///////////////////////////  Set shared preference ///////////////////////////////////////////////////////

        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userUID', userUID);
        await prefs.setString('userPws', userPws);

///////////////////////////  Set shared preference ///////////////////////////////////////////////////////

        setData(context);

        Navigator.pushReplacementNamed(context, '/mainmgt');
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Galaxy Pharma App',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: MediaQuery.of(context).size.height * .024),
        ),
        backgroundColor: Colors.greenAccent[400],
        actions: [
          IconButton(
            icon: Image.asset('assets/images/alifsoftlogo.jpg'),
            onPressed: () => {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _header(context),
                _inputField(context),
                _companyLogo(context),
                _footer(context),
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

    return Container(
      height: height * .13,
      width: width * .3,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.purple,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(11.0)),
      ),
      child: Text(
        "Galaxy Pharma ERP",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: height * .022,
            color: Colors.white,
            fontWeight: FontWeight.w900),
      ),
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: userTxtCntrl,
          decoration: InputDecoration(
              hintText: "User Id",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
              filled: true,
              prefixIcon: Icon(Icons.person)),
        ),
        SizedBox(height: 10),
        TextField(
          controller: passTxtCntrl,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: _togglePasswordVisibility,
            ),
          ),
          obscureText: _isPasswordVisible,
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => _loginPressed(context),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
             Expanded(
               flex: 1,
               child: Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text(
                    "Exit",
                    style: TextStyle(fontSize: 20, color: Colors.red),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                             ),
               ),
             ),
          ],
        )
      ],
    );
  }

  _companyLogo(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          'assets/images/ziskaPharmaIcon.png',
          height: width * .3,
          width: width * .3,
        ),
        Text(
          'Ziska Pharmaceuticals Ltd.',
          style:
              TextStyle(fontSize: height * .023, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _footer(context) {
    final provider = Provider.of<AuthProvider>(context);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/alifsoft.PNG',
        ),
        Text(
          "Developed By : Alif Soft ",
          style:
              TextStyle(fontSize: height * .023, fontWeight: FontWeight.w500),
        ),
        Text(
          "Mobile No : +88-01817042056 ",
          style:
              TextStyle(fontSize: height * .017, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
