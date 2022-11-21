class Record {
  // 记录表
  static const String tableSql = """
CREATE TABLE `recoder` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `title` VARCHAR(256) ,
  `content` TEXT
)
""";

  final int id;
  final String title;
  final String content;

  const Record({
    required this.id,
    required this.title,
    required this.content,
  });


  const Record.i({
    this.id = -1,
    required this.title,
    required this.content,
  });

  factory Record.fromJson(dynamic map) {
    return Record(
      id: map['id'],
      title: map['title'],
      content: map["content"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id == -1 ? null : id,
        "title": title,
        "content": content,
      };

  @override
  String toString() {
    return 'Record{id: $id, title: $title}';
  }
}
