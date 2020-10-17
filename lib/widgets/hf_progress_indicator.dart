import 'package:flutter/material.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';
import 'package:hacktoberfest_checker/models/user.dart';

class HacktoberfestProgressIndicator extends StatelessWidget {
  User user;
  List<PullRequest> pull_requests;

  List<Widget> _makeProgressBar() {
    List<Widget> progressBar = [];
    for (int i = 0; i < 4; i++) {
      try {
        PullRequest pr = pull_requests[i];
        progressBar.add(Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.purpleAccent,
                  width: 0.3),
              color: pr.hasMatured() ? Colors.purple : Colors.orange,
            ),
          ),
        ));
      } on RangeError {
        progressBar.add(Flexible(
          flex: 1,
          child: Container(
            color: Colors.white,
          ),
        ));
      }
    }
    return progressBar;
  }


  HacktoberfestProgressIndicator({
    @required this.user,
    @required this.pull_requests
  });

  @override
  Widget build(BuildContext context) {
    final int completedPRs = this.pull_requests.length;
    // final int completedPRs = 3;
    String completedPRsText;
    switch (completedPRs) {
      case 0:
        completedPRsText = "Start Hacking! 0/4 Completed!";
        break;
      case 1:
        completedPRsText = "Well done! 1/4 Completed!";
        break;
      case 2:
        completedPRsText = "Halfway done! 2/4 Completed!";
        break;
      case 3:
        completedPRsText = "Almost There! 3/4 Completed!";
        break;
      case 4:
        completedPRsText = "You have completed the Hacktoberfest Challenge!";
        break;
    }
    int indicatedPRs;
    if (completedPRs > 4) {
      indicatedPRs = 4;
    } else
      indicatedPRs = completedPRs;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      height: MediaQuery
          .of(context)
          .size
          .height * 0.15,
      width: MediaQuery
          .of(context)
          .size
          .width * 0.7,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery
              .of(context)
              .size
              .height * 0.03,
          horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.1
      ),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple),
          color: const Color.fromARGB(255, 255, 138, 226),
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Row(
                  children: _makeProgressBar(),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Center(child: Text(completedPRsText))
          )
        ],
      ),
    );
  }
}
