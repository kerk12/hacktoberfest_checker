
import 'package:dio/dio.dart';
import 'package:hacktoberfest_checker/models/pull_request.dart';
import 'package:hacktoberfest_checker/models/user.dart';

class InvalidUserException implements Exception {
  InvalidUserException();
}

class ApiError implements Exception {
  ApiError();
}


class GitHubService {
  final String username;

  GitHubService(this.username);

  // TODO What happens if the Wi-Fi is Disconnected and/or no data?
  Future<List<PullRequest>> getPRs() async {
    String url = "https://api.github.com/search/issues?q=author:$username%20type:pr%20created:%3E2021-09-30";

    var response = await Dio().get(url);
    var json = response.data;
    List<PullRequest> prs = [];
    for (Map<String, dynamic> pr in json["items"]) {
      // Identify labels.
      List<String> labels = [];
      for (Map<String, dynamic> l in pr["labels"]){
        labels.add(l["name"]);
      }

      bool belongsToHFRepo = false;
      // Search in labels for hacktoberfest-accepted.
      if (labels.contains("hacktoberfest-accepted"))
        belongsToHFRepo = true;

      // If still not found, search within the repo it belongs for the Hacktoberfest topic.
      if (!belongsToHFRepo) {
        Map<String, String> repoData = await getRepoData(pr["repository_url"]);
        belongsToHFRepo = await getBelongsToHFRepo(repoData["repoOwner"], repoData["repoName"]);
      }

      // TODO add invalid PR identification.
      DateTime closedAt = DateTime.parse(pr["closed_at"]);

      prs.add(PullRequest(
          prUrl: pr["html_url"],
          createdAt: DateTime.parse(pr["created_at"]),
          prState: pr["state"] == "closed"
              ? PullRequestState.closed
              : PullRequestState.open,
          labels: labels,
          closedAt: closedAt,
          belongsToHFRepo: belongsToHFRepo));
    }
    return prs;
  }

  Future<User> getUserData() async{
    String url = "https://api.github.com/users/$username";

    var response = await Dio().get(url);
    if (response.statusCode != 200)
      throw InvalidUserException();

    return User(
      username: username,
      realName: response.data["name"],
      profileUrl: response.data["html_url"]
    );
  }

  Future<Map<String, String>> getRepoData(String repoUrl) async {
    var response = await Dio().get(repoUrl);
    if (response.statusCode != 200)
      throw ApiError();

    var json = response.data;
    String repoName = json["name"];
    String repoOwner = json["owner"]["login"];
    return {
      "repoName": repoName,
      "repoOwner": repoOwner
    };
  }

  Future<bool> getBelongsToHFRepo(String repoOwner, String repoName) async {
    String url = "https://api.github.com/repos/$repoOwner/$repoName/topics";
    var response = await Dio().get(url, options: Options(headers: {"Accept": "application/vnd.github.mercy-preview+json"}));

    if (response.statusCode != 200)
      throw ApiError();

    var json = response.data;
    List topics = json["names"];
    return (topics.contains("Hacktoberfest") || topics.contains("hacktoberfest"));
  }
}