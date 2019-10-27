import 'dart:html';
import 'dart:js' as js;

import 'package:dart_pub_badge_maker/badge_maker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
              Text(
                "Badge maker for pub.dev packages",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 42.0,
                ),
              ),
              SizedBox(height: 6.0),
              GestureDetector(
                onTap: () => js.context.callMethod("open", ["https://twitter.com/modulovalue"]),
                child: Text(
                  "Made by @modulovalue",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                    fontSize: 12.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 4.0),
              GestureDetector(
                onTap: () => js.context.callMethod("open", ["https://github.com/modulovalue/dart_pub_badge_maker"]),
                child: Text(
                  "Github",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[700],
                    fontSize: 12.0,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
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
                SizedBox(height: 24.0),
                RaisedButton(
                  child: Text("Select All"),
                  onPressed: () {
                    resultTextController.selection = TextSelection(
                      baseOffset: 0,
                      extentOffset: resultTextController.text.length,
                    );
                  },
                ),
                SizedBox(height: 8.0),
                Text(
                    "Select All > Right Click > Copy > Paste that into your README.md"),
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
}
