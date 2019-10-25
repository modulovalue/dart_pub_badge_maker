import 'package:meta/meta.dart';

abstract class ShieldsBadge {
  String makeLink();
}

class SimpleShieldsBadge implements ShieldsBadge {
  final BadgeStyle style;
  final String color;
  final String leftText;
  final String rightText;
  final ShieldsBadgeLogo logo;

  const SimpleShieldsBadge({
    @required this.style,
    @required this.color,
    @required this.logo,
    @required this.leftText,
    @required this.rightText,
  });

  @override
  String makeLink() =>
      "https://img.shields.io/badge/${Uri.encodeComponent(leftText)}-"
      "${Uri.encodeComponent(rightText)}-${color}?"
      "style=${style.style}"
      "&logo=${logo.makeLogo()}";
}

class SmartShieldsBadge implements ShieldsBadge {
  final String link;
  final BadgeStyle style;
  final ShieldsBadgeLogo logo;

  const SmartShieldsBadge({
    @required this.link,
    @required this.style,
    this.logo,
  });

  @override
  String makeLink() => [
        link,
        "?",
        "style=${style.style}",
        if (logo != null) //
          "&logo=${logo.makeLogo()}",
      ].join();
}

class BadgeStyle {
  final String style;

  const BadgeStyle(this.style);

  const BadgeStyle.plastic() : style = "plastic";

  const BadgeStyle.flat() : style = "flat";

  const BadgeStyle.flatSquare() : style = "flat-square";

  const BadgeStyle.forTheBadge() : style = "for-the-badge";

  const BadgeStyle.social() : style = "social";
}

abstract class ShieldsBadgeLogo {
  String makeLogo();
}

class ShieldsBadgeBase64Logo implements ShieldsBadgeLogo {
  final String rawBase64Image;

  const ShieldsBadgeBase64Logo(this.rawBase64Image);

  @override
  String makeLogo() => rawBase64Image;
}

class ShieldsBadgeImageLogo implements ShieldsBadgeLogo {
  final String image;

  const ShieldsBadgeImageLogo(this.image);

  @override
  String makeLogo() => image;
}
