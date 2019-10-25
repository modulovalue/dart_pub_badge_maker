import 'package:meta/meta.dart';

import 'shields_badge.dart';

abstract class BadgeItem {
  String makeMarkdownString();
}

class Badge implements BadgeItem {
  final String link;
  final String altText;
  final ShieldsBadge badgeContent;

  const Badge({
    @required this.altText,
    @required this.badgeContent,
    this.link,
  });

  @override
  String makeMarkdownString() {
    if (link == null) {
      return '''![$altText](${badgeContent.makeLink()})''';
    } else {
      return '''[![$altText](${badgeContent.makeLink()})]($link)''';
    }
  }
}

class BadgeSpace implements BadgeItem {
  @override
  String makeMarkdownString() => " ";
}

class BadgeNewLine implements BadgeItem {
  @override
  String makeMarkdownString() => '''

''';
}
