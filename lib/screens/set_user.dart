import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            image: AssetImage("assets/hf2020_logo_blur.png"),
            fit: BoxFit.contain,
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
                  Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
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
                          // TODO Check if username is empty
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: (state is UserDataError && state.error == UserDataErrorType.userNotFound) ? 10 : 0,
                        ),
                        Opacity(
                          child: Text("Invalid username provided",
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                          opacity: (state is UserDataError && state.error == UserDataErrorType.userNotFound) ? 1 : 0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                        ),
                        RaisedButton.icon(
                          onPressed:() async {
                            if (state is UserDataLoading)
                              return;
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
