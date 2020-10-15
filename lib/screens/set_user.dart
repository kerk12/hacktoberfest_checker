import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hacktoberfest_checker/blocs/home_screen/home_screen_bloc.dart';
import 'package:hacktoberfest_checker/blocs/userdata/userdata_bloc.dart';
import 'package:hacktoberfest_checker/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            BlocListener<UserdataBloc, UserDataState>(
              listener: (context, state) async {
                if (state is UserDataLoaded){
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  sp.setString("github_username", _usernameController.value.text);
                  Navigator.of(context).pushNamedAndRemoveUntil("/", (route) => false);
                }
              },
              child: BlocBuilder<UserdataBloc, UserDataState> (
                builder: (context, state) {
                  return Form(
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
                          onPressed:() async {
                            if (_formKey.currentState.validate()){
                              final userdatabloc = BlocProvider.of<UserdataBloc>(context);
                              userdatabloc.add(RequestSetUser(username:_usernameController.value.text));
                            }
                          },
                          color: Colors.blue,
                          icon: Icon(Icons.save),
                          label: Text("Set"),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
