import 'dart:html';

import 'package:dart_pub_badge_maker/badge_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:modulovalue_project_widgets/all.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dart & Flutter Package Badge Maker for pub.dev libraries',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _MainWidget(),
    );
  }
}

class _MainWidget extends StatefulWidget {
  @override
  __MainWidgetState createState() => __MainWidgetState();
}

class __MainWidgetState extends State<_MainWidget> {
  String githubUser;
  String repo;
  String twitterUser;
  String mediumLink;
  TextEditingController resultTextController;

  bool showTravis = true;
  bool showCodeCov = true;
  bool showLicense = true;
  bool showPubDev = true;
  bool showGitHubRepo = true;
  bool showGitHubProfile = true;

  @override
  void initState() {
    super.initState();
    resultTextController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(34.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ...modulovalueTitle(
                  "Badge maker for pub.dev packages", "dart_pub_badge_maker"),
              SizedBox(height: 36.0),
              TextField(
                decoration: InputDecoration(hintText: "GitHub User"),
                onChanged: (text) => setState(() => githubUser = text),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: "Repo"),
                onChanged: (text) => setState(() => repo = text),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration:
                    InputDecoration(hintText: "Twitter handle (optional)"),
                onChanged: (text) => setState(() => twitterUser = text),
              ),
              SizedBox(height: 8.0),
              TextField(
                decoration: InputDecoration(hintText: "Medium Link (optional)"),
                onChanged: (text) => setState(() => mediumLink = text),
              ),
              SizedBox(height: 32.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Travis CI"),
                  Checkbox(
                    value: showTravis,
                    onChanged: (v) => setState(() => showTravis = v),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Codecov"),
                  Checkbox(
                    value: showCodeCov,
                    onChanged: (v) => setState(() => showCodeCov = v),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("GitHub License"),
                  Checkbox(
                    value: showLicense,
                    onChanged: (v) => setState(() => showLicense = v),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("pub.dev"),
                  Checkbox(
                    value: showPubDev,
                    onChanged: (v) => setState(() => showPubDev = v),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("GitHub Repo"),
                  Checkbox(
                    value: showGitHubRepo,
                    onChanged: (v) => setState(() => showGitHubRepo = v),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("GitHub Profile"),
                  Checkbox(
                    value: showGitHubProfile,
                    onChanged: (v) => setState(() => showGitHubProfile = v),
                  ),
                ],
              ),
              RaisedButton(
                child: Text("Make"),
                onPressed: githubUser == null || repo == null
                    ? null
                    : () {
                        final text = badgeListMaker(
                          style: const BadgeStyle.flatSquare(),
                          socialStyle: const BadgeStyle.social(),
                          githubUser: githubUser,
                          repo: repo,
                          twitterUser: twitterUser,
                          mediumLink: mediumLink,
                        ).map((a) => a.makeMarkdownString()).join();

                        setState(() {
                          resultTextController.text = text;
                        });
                      },
              ),
              if (resultTextController.text != "") //
                ...[
                SizedBox(height: 24.0),
                Container(
                  color: Colors.blue.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: MarkdownBody(data: resultTextController.text),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                    "Ctrl/Cmd+A > Ctrl/Cmd+C > Paste that into your README.md"),
                TextField(
                  controller: resultTextController,
                  decoration: InputDecoration(hintText: "Result"),
                  onChanged: (text) => setState(() => mediumLink = text),
                ),
              ],
            ],
          ),
        ),
      )),
    );
  }

  List<BadgeItem> badgeListMaker({
    @required BadgeStyle style,
    @required String githubUser,
    @required String repo,
    BadgeStyle socialStyle,
    String mediumLink,
    String twitterUser,
  }) {
    return [
      if (mediumLink != null && mediumLink != "") //
        ...[
        mediumBadge(mediumLink, style),
        BadgeSpace(),
      ],
      if (showTravis) //
        ...[
        travisCIBadge(githubUser, repo, style),
        BadgeSpace(),
      ],
      if (showCodeCov) //
        ...[
        codecovBadge(githubUser, repo, style),
        BadgeSpace(),
      ],
      if (showLicense) //
        ...[
        githubLicenseBadge(githubUser, repo, style),
        BadgeSpace(),
      ],
      if (showPubDev) //
        ...[
        pubDevBadge(repo, style),
        BadgeSpace(),
      ],
      if (showGitHubRepo) //
        ...[
        githubStarsBadge(githubUser, repo, style),
        BadgeSpace(),
      ],
      if (twitterUser != null && twitterUser != "") //
        ...[
        twitterBadge(twitterUser, socialStyle ?? style),
        BadgeSpace(),
      ],
      if (showGitHubProfile)
        githubFollowersBadge(githubUser, socialStyle ?? style)
    ];
  }
}
