import 'match_rule.dart';

abstract class CommentMatchRule implements MatchRule {
  const CommentMatchRule();
}

//注释符: #
class HashCommentRule extends CommentMatchRule  {
  const HashCommentRule();
  @override
  Pattern get pattern => RegExp(r'#.*');
}

//注释符: //
class Slash2CommentRule extends CommentMatchRule  {
  const Slash2CommentRule();
  @override
  Pattern get pattern => RegExp(r'//.*');
}

//注释符: ///
class Slash3CommentRule extends CommentMatchRule {
  const Slash3CommentRule();

  @override
  Pattern get pattern => RegExp(r'///.*');
}

//注释符: /**/
class BlocCommentRule extends CommentMatchRule {
  const BlocCommentRule();

  @override
  Pattern get pattern => RegExp(r'/\*(.|\n)*\*/');
}