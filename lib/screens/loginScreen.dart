// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  void _loginPressed(BuildContext context) {
    print("Login pressed");
    if (userTxtCntrl.text == 'admin' && passTxtCntrl.text == '123') {
      Navigator.pushReplacementNamed(context, '/mainmgt');
    } else {
      Navigator.pushReplacementNamed(context, '/mainmgt');
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(const SnackBar(content: Text('Wrong Username or Password')));
    }
  }

  final userTxtCntrl = TextEditingController();
  final passTxtCntrl = TextEditingController();

  @override
  void dispose() {
    userTxtCntrl.dispose();
    passTxtCntrl.dispose();
    super.dispose();
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
            fontSize: MediaQuery.of(context).size.height*.024
          ),
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
        child: Container(
          margin: EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
              _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height*.13,
      width: width*.3,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.purple,
        border: Border.all(),
        borderRadius: BorderRadius.all(Radius.circular(11.0)),
      ), //             <--- BoxDecoration here
      child: Text(
        "Galaxy Pharma ERP",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: height * .022, color: Colors.white, fontWeight: FontWeight.w900),
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
            prefixIcon: Icon(Icons.person),
          ),
          obscureText: true,
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () => _loginPressed(context),
          child: Text(
            "SIGN IN",
            style: TextStyle(fontSize: 20),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Image.asset(
          'assets/images/ziskaPharmaIcon.png',
          height: width *.3,
          width: width * .3,
        ),
        Text(
          'Ziska Pharmaceuticals Ltd.',
          style: TextStyle(fontSize:  height * .023, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _signup(context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/alifsoft.PNG',
        //  height: width * .2,
        //   width: width * .2,
        ),
        Text(
          "Developed By : Alif Soft ",
          style: TextStyle(fontSize: height*.023, fontWeight: FontWeight.w500),
        ),
        Text(
          "Mobile No : +88-01817042056 ",
          style: TextStyle(fontSize:  height * .017, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
