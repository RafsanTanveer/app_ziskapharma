import 'package:flutter/material.dart';

class Mainmgtscreen extends StatelessWidget {
  void _loginPressed(BuildContext context) {
    print("Login pressed");
    Navigator.pushReplacementNamed(context, '/areasetting');
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
              _signup(context),
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

            mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
                onPressed: () => {},
                child: Text(
                  "SALES",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 56, horizontal: 36),
                ),
              ),
               ElevatedButton(
                onPressed: () => {},
                child: Text(
                  "SALES",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 56, horizontal: 36),
                ),
              )
          ],),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {},
                child: Text(
                  "SALES",
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 56, horizontal: 36),
                ),
              ),
              ElevatedButton(
                onPressed: () => {},
                child: Text(
                  "QR Code Scan",
                  style: TextStyle(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(vertical: 56, horizontal: 36),
                ),
              )
            ],
          ),
        ),

      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
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

  _signup(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/alifsoft.PNG'),
        Text(
          "Developed By : Alif Soft ",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        Text(
          "Mobile No : +88-01817042056 ",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
