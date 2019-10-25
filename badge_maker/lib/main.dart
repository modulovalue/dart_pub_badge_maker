import 'dart:html';

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
  String githubUser = "";
  String repo = "";
  String twitterUser = "";
  String mediumLink = "";

  String generatedText;

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
              SizedBox(height: 24.0),
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
                          generatedText = text;
                        });
                      },
              ),
              if (generatedText != null) //
                ...[
                SizedBox(height: 24.0),
                Text("Add this text to your README.md"),
                SizedBox(height: 12.0),
                MarkdownBody(data: generatedText),
                RaisedButton(
                  child: Text("Copy to clipboard"),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: generatedText));
                  },
                ),
                SizedBox(height: 24.0),
                Text(generatedText),
              ],
            ],
          ),
        ),
      )),
    );
  }
}
