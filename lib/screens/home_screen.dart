import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hacktoberfest_checker/blocs/userdata/userdata_bloc.dart';
import 'package:hacktoberfest_checker/screens/set_user.dart';
import 'package:hacktoberfest_checker/widgets/hf_progress_indicator.dart';
import 'package:hacktoberfest_checker/widgets/pr_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Hacktoberfest Checker",
            style: TextStyle(
                fontFamily: 'Gemunu', color: Colors.white, fontSize: 30),
          ),
          backgroundColor: Color(0xFFFF7643),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  SharedPreferences sp = await SharedPreferences.getInstance();
                  UserdataBloc udb = BlocProvider.of<UserdataBloc>(context);
                  udb.add(RequestSetUser(
                      username: sp.getString("github_username")));
                },
                child: Icon(
                  Icons.refresh
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () async {
                  // SharedPreferences sp = await SharedPreferences.getInstance();
                  // UserdataBloc udb = BlocProvider.of<UserdataBloc>(context);
                  // udb.add(RequestSetUser(
                  //     username: sp.getString("github_username")));
                  SharedPreferences userData = await SharedPreferences.getInstance(); 
                  await userData.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SetUserScreen(),
                      ));
                },
                child: Icon(
                  Icons.logout,
                ),
              ),
            )
            // TODO Add a "change user" button.
            // The button should redirect to the SetUserScreen and remove the old username from SP.
          ],
        ),
        body: BlocBuilder<UserdataBloc, UserDataState>(
          builder: (context, state) {
            if (state is UserDataLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserDataError) {
              // TODO Implement...
            }

            // TODO Fix user is null error thrown sometimes. Needs testing.
            UserDataLoaded st = state;
            return Container(
              padding: EdgeInsets.only(top: 10),
              height: double.infinity,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset("assets/HF2021_Logo.svg",
                              semanticsLabel: 'Hacktoberfest 2021 Logo'),
                        )),
                    Expanded(
                        flex: 4,
                        child: HacktoberfestProgressIndicator(
                            user: st.user, pull_requests: st.prs)),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            "Pull Requests for user ${st.user.username}:",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Gemunu',
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Flexible(flex: 4, child: PRList(pullRequests: st.prs)),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
