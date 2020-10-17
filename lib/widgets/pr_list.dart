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
            color: Colors.grey,
          ),
        );
      } else if (pullRequest.hasMatured()){
        prStatus = Text(
          "Accepted",
          style: TextStyle(
            color: Colors.purpleAccent,
          ),
        );
      } else {
        prStatus = Text(
          "In Review/Not Mature",
          style: TextStyle(
            color: Colors.orange,
          ),
        );
      }
      // TODO Add spam status
    } else {
      prStatus = Text(
        "Ineligible Repository",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }

    return Card(
      child: ListTile(
        // TODO Add Repo Image
        title: Text(pullRequest.prUrl),
        subtitle: Row(
          children: [
            Text(
              "Status: ",
              style: TextStyle(
                fontWeight: FontWeight.bold
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
    return ListView.builder(
      itemBuilder: (context, index) {
        return _PRListItem(pullRequest: pullRequests[index]);
      },
      itemCount: pullRequests.length,
    );
  }
}
