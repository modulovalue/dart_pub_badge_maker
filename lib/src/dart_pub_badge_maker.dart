import 'package:meta/meta.dart';

import '../badge_maker.dart';

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
    travisCIBadge(githubUser, repo, style),
    BadgeSpace(),
    codecovBadge(githubUser, repo, style),
    BadgeSpace(),
    githubLicenseBadge(githubUser, repo, style),
    BadgeSpace(),
    pubDevBadge(repo, style),
    BadgeSpace(),
    githubStarsBadge(githubUser, repo, style),
    BadgeNewLine(),
    if (twitterUser != null && twitterUser != "") //
      ...[
      twitterBadge(twitterUser, socialStyle ?? style),
      BadgeSpace(),
    ],
    githubFollowersBadge(githubUser, socialStyle ?? style)
  ];
}
