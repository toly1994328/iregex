import 'impl/db/model/link_regex.dart';
import '../../11/repository/impl/db/model/record.dart';

abstract class LinkRegexRepository {
  /// 查询记录
  Future<List<LinkRegex>> queryLinkRegexByRecordId({
   required int recordId,
  });

  /// 插入记录
  Future<int> insert(LinkRegex record);

  /// 根据 [id] 删除记录
  Future<int> deleteById(int id);

  /// 修改记录
  Future<int> update(LinkRegex record);
}
