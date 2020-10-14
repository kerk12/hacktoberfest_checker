import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SetUserScreen extends StatefulWidget {
  @override
  _SetUserScreenState createState() => _SetUserScreenState();
}

class _SetUserScreenState extends State<SetUserScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Icon_new.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(50),
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [
             Text(
                "Set your Username:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
            ),
            Text("Type your GitHub Username in the field below."),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                        hintText: "Username (eg. kerk12)",
                        labelText: "Username"
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                  ),
                  RaisedButton.icon(
                    onPressed:(){
                      if (_formKey.currentState.validate()){

                      }
                    },
                    color: Colors.blue,
                    icon: Icon(Icons.save),
                    label: Text("Set"),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
