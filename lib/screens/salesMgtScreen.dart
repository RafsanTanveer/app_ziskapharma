import 'package:app_ziskapharma/model/CustomerSettingScreenArgs.dart';
import 'package:app_ziskapharma/model/UserPreferences.dart';
import 'package:app_ziskapharma/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dataaccess/apiAccess.dart' as apiAccess;

class Salesmgtscreen extends StatelessWidget {
  Future<String> getMenuId(String menuFormName) async {
    final url = Uri.parse(
        '${apiAccess.apiBaseUrl}/MyMenuControl/Proc_MenuID?menu_FormName=$menuFormName');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return '';
      }
    } catch (e) {
      return '';
    }
  }

  Future<bool> userAccessMenuYN(int menuId, String userId) async {
    final url = Uri.parse(
        '${apiAccess.apiBaseUrl}/MyMenuControl/userAccessMenuYN?MenuID=$menuId&UserId=$userId');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        String responseBody =
            response.body.replaceAll('"', '').trim().toLowerCase();
        bool isTrue = responseBody == 'true';

        return isTrue;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void _handleButtonClick(
      BuildContext context, String menuFormName, String route,
      {Object? arguments}) async {
    UserPreferences? userPreferences =
        context.read<AuthProvider>().userPreferences;
    String userId = userPreferences?.userUID ?? '';

    if (userId.isNotEmpty) {
      var menuIdString = await getMenuId(menuFormName);
      menuIdString = menuIdString.replaceAll('"', '').trim();
      var menuId = int.tryParse(menuIdString) ?? 0;

      if (menuId != 0) {
        bool hasAccess = await userAccessMenuYN(menuId, userId);
        print(hasAccess);
        if (hasAccess) {
          Navigator.pushNamed(context, route, arguments: arguments);
        } else {
          Fluttertoast.showToast(
            msg: 'You do not have access to this menu.',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 18.0,
          );
        }
      } else {
        Fluttertoast.showToast(
          msg: 'Failed to retrieve menu ID.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 18.0,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'User ID is not available.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 18.0,
      );
    }
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
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      _header(context),
                      _companyLogo(context, userPreferences),
                      Spacer(),
                      // _footer(context, userPreferences),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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
              _buildButtonNoValidation(
                  context, '/userinfo', 'USER INFO CHANGE', isWideScreen),
              _buildButton(context, 'frmUserWiseAreaSettings', '/areasetting',
                  'DEFAULT TERRITORY', isWideScreen),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, 'frmCustomerList', '/cutomergrouplist',
                  'CUSTOMER LIST', isWideScreen),
              _buildButton(
                  context,
                  'frmSalesOrderEntry',
                  '/cutomergrouplistforsales',
                  'SALES ORDER ONCO',
                  isWideScreen),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(
                  context,
                  'frmSalesCustomerEntry',
                  '/cutomergrouplistforsetting',
                  'CUSTOMER SETTINGS',
                  isWideScreen),
              _buildButton(context, 'frmSalesCustomerEntry', '/doctorsettings',
                  'DOCTOR SETTING', isWideScreen,
                  arguments: CustomerSettingScreenArgs('03', 'doctor', '')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(context, 'frmSalesInvoiceApproval', '/slsinvview',
                  'INVOICE APPROVAL', isWideScreen),
              _buildButtonNoValidation(
                  context, '/doctorlist', 'DOCTORS LIST', isWideScreen,
                  arguments: CustomerSettingScreenArgs('03', 'doctor', '')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildButtonNoValidation(
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
        style: ElevatedButton.styleFrom(
          elevation: 3,
          maximumSize: Size(maxWidth, maxWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String menuFormName, String route,
      String text, bool isWideScreen,
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
        onPressed: () => _handleButtonClick(context, menuFormName, route,
            arguments: arguments),
        style: ElevatedButton.styleFrom(
          elevation: 3,
          maximumSize: Size(maxWidth, maxWidth),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(vertical: padding, horizontal: padding),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _companyLogo(BuildContext context, UserPreferences? user) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    double fontSize = MediaQuery.of(context).size.width * .040;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/ziskaPharmaIcon.png',
          height: 100,
          width: 100,
        ),
        const Text(
          'Ziska Pharmaceuticals Ltd.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        Text(
          (user?.userFullName ?? ""),
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w500),
        ),
        Text(
          "Territory: ${user?.teryCode ?? ""}",
          style:
              TextStyle(fontSize: fontSize * .75, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
