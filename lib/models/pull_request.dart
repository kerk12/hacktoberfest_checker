import 'package:flutter/cupertino.dart';

enum PullRequestState {
  open,
  closed
}

class PullRequest {
  String prUrl;
  DateTime createdAt;
  PullRequestState prState;
  DateTime closedAt;
  List<String> labels;
  bool belongsToHFRepo;

  PullRequest({
    @required this.prUrl,
    @required this.createdAt,
    @required this.prState,
    @required this.labels,
    this.closedAt,
    @required this.belongsToHFRepo
  });

  DateTime getMatureDate(){
    return this.closedAt.add(Duration(days: 14));
  }

  bool hasMatured() {
    if (prState != PullRequestState.closed)
      return false;

    final DateTime maturingDt = getMatureDate();
    final DateTime now = DateTime.now().toUtc();
    Duration diff = now.difference(maturingDt);
    print(diff.inSeconds);
    return diff.inSeconds > 0;
  }
}