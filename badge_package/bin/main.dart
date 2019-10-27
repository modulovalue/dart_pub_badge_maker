import 'package:dart_pub_badge_maker/badge_maker.dart';

void main() {
  print(badgeListMaker(
    style: const BadgeStyle.flatSquare(),
    socialStyle: const BadgeStyle.social(),
    githubUser: "modulovalue",
    repo: "dart_filter",
    twitterUser: "modulovalue",
  ).map((a) => a.makeMarkdownString()).join());
}
