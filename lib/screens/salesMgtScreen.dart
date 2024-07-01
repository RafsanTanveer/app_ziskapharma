import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return _buildWideScreenLayout(context, userPreferences);
            } else {
              return _buildNarrowScreenLayout(context, userPreferences);
            }
          },
        ),
      ),
    );
  }

  Widget _buildWideScreenLayout(
      BuildContext context, UserPreferences? userPreferences) {
    return Container(
      margin: EdgeInsets.all(14),
      child: Column(
        children: [
          _header(context, isWideScreen: true),
          _forgotPassword(context),
          _signup(context, userPreferences),
        ],
      ),
    );
  }

  Widget _buildNarrowScreenLayout(
      BuildContext context, UserPreferences? userPreferences) {
    return Container(
      margin: EdgeInsets.all(14),
      child: Column(
        children: [
          _header(context),
          _forgotPassword(context),
          _signup(context, userPreferences),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, {bool isWideScreen = false}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  context, '/userinfo', 'USER INFO CHANGE', isWideScreen),
              _buildButton(
                  context, '/areasetting', 'DEFAULT TERRITORY', isWideScreen),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  context, '/cutomergrouplist', 'CUSTOMER LIST', isWideScreen),
              _buildButton(context, '/cutomergrouplistforsales',
                  'SALES ORDER ONCO', isWideScreen),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, '/cutomergrouplistforsetting',
                  'CUSTOMER SETTINGS', isWideScreen),
              _buildButton(
                  context, '/doctorsettings', 'DOCTOR SETTING', isWideScreen,
                  arguments: CustomerSettingScreenArgs('03', 'doctor', '')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  context, '/slsinvview', 'INVOICE APPROVAL', isWideScreen),
              _buildButton(
                  context, '/customerlist', 'DOCTORS LIST', isWideScreen,
                  arguments: CustomerSettingScreenArgs('03', 'doctor', '')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
      BuildContext context, String route, String text, bool isWideScreen,
      {Object? arguments}) {
    double fontSize =
        isWideScreen ? 18 : MediaQuery.of(context).size.height * .022;
    double padding = isWideScreen ? 20 : 10;
    double maxWidth = isWideScreen ? 200 : 150;

    return Container(
      height: MediaQuery.of(context).size.height * .12,
      width: MediaQuery.of(context).size.width * .4,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () =>
            Navigator.pushNamed(context, route, arguments: arguments),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          maximumSize: Size(maxWidth, maxWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
        ),
      ),
    );
  }

  Widget _forgotPassword(BuildContext context) {
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

  Widget _signup(BuildContext context, UserPreferences? user) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    double fontSize = MediaQuery.of(context).size.width * .040;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          (user?.userFullName ?? ""),
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ),
        Text(
          "Territory: " + (user?.teryCode ?? ""),
          style:
              TextStyle(fontSize: fontSize * .75, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
