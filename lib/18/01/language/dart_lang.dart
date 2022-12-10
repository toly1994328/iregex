import '../rules/class_name.dart';
import '../rules/comment.dart';
import '../rules/key_words.dart';
import '../rules/line.dart';
import '../rules/meta.dart';
import '../rules/num.dart';
import '../rules/string.dart';
import '../rules/type.dart';
import 'language.dart';

class DartLanguage extends Language {
  DartLanguage() : super('dart');

  @override
  void initRules() {

    add(const BlocCommentRule());
    add(const Slash3CommentRule());
    add(const Slash2CommentRule());

    add(const ThreeSingleQuotesRule());
    add(const ThreeQuotesRule());
    add(const RawDoubleQuotesRule());
    add(const RawSingleQuotesRule());
    add(const DoubleQuotesRule());
    add(const SingleQuotesRule());

    add(KeywordsRule(keywords));
    add(const ClassNameRule());
    add(const TypeRule());

    add(const NumRule());
    add(const MetaRule());
  }

  @override
  List<String> get keywords => [
    'abstract', 'as', 'assert', 'async', 'await', 'break', 'case', 'catch',
    'class', 'const', 'continue', 'default', 'deferred', 'do', 'dynamic', 'else',
    'enum', 'export', 'external', 'extends', 'factory', 'false', 'final',
    'finally', 'for', 'get', 'if', 'implements', 'import', 'in', 'is', 'library',
    'new', 'null', 'operator', 'part', 'required', 'rethrow', 'return', 'set', 'static',
    'super', 'switch', 'sync', 'this', 'throw', 'true', 'try', 'typedef', 'var',
    'void', 'while', 'with', 'yield'
  ];
}



