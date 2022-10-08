import 'package:flutter/material.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';

class _PRListItem extends StatelessWidget {
  PullRequest pullRequest;

  _PRListItem({@required this.pullRequest});

  @override
  Widget build(BuildContext context) {
    Widget prStatus;
    if (pullRequest.belongsToHFRepo) {
      if (pullRequest.prState == PullRequestState.open) {
        prStatus = Text(
          "Open/Pending",
          style: TextStyle(
            color: Colors.blue,
            fontFamily: 'Gemunu',
          ),
        );
      } else if (pullRequest.hasMatured()) {
        prStatus = Text(
          "Accepted",
          style: TextStyle(
            color: Colors.yellow,
            fontFamily: 'Gemunu',
          ),
        );
      } else {
        prStatus = Text(
          "In Review/Not Mature",
          style: TextStyle(
            color: Colors.orange,
            fontFamily: 'Gemunu',
          ),
        );
      }
      // TODO Add spam status
    } else {
      prStatus = Text(
        "Ineligible Repository",
        style: TextStyle(
          color: Colors.grey,
          fontFamily: 'Gemunu',
        ),
      );
    }

    return Card(
      color: Color(0xFFFF7643),
      child: ListTile(
        // TODO Add Repo Image
        // TODO On Click, open up a browser window and show the PR to the user.
        title: Text(
          pullRequest.prUrl,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Row(
          children: [
            Text(
              "Status: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Gemunu',
              ),
            ),
            prStatus
          ],
        ),
      ),
    );
  }
}

class PRList extends StatelessWidget {
  List<PullRequest> pullRequests;

  PRList({@required this.pullRequests});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
        color: Color(0xFFFF7643),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _PRListItem(pullRequest: pullRequests[index]);
        },
        itemCount: pullRequests.length,
      ),
    );
  }
}
