class DbHelper{
  // 记录表
  static const String createRecoder =
"""
CREATE TABLE `recoder` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `title` VARCHAR(256) ,
  `content` TEXT
)
""";
}