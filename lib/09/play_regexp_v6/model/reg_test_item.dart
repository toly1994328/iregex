class RegTestItem {
  final String title;
  final String subtitle;
  final List<String> recommend;
  final String content;

  RegTestItem({
    required this.title,
    required this.subtitle,
    this.recommend = const [],
    required this.content,
  });

  factory RegTestItem.fromJson(Map<String, dynamic> map) {
    List<dynamic> recommend = map["recommend"];

    return RegTestItem(
        title: map['title'],
        subtitle: map["subtitle"],
        recommend: recommend.map((e) => e.toString()).toList(),
        content: map["content"]);
  }

  @override
  String toString() {
    return 'RegTestItem{title: $title, subtitle: $subtitle, recommend: $recommend, content: $content}';
  }
}
