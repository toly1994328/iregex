import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/impl/db/model/record.dart';

import '../repository/impl/db/dao/record_dao.dart';
import '../repository/impl/db/helper/default_data.dart';
import '../repository/impl/db/local_db.dart';
import '../repository/impl/db_recode_repository.dart';
import '../views/record/bloc/record_bloc.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async{
        // 增
        // DbRecoderRepository repository = DbRecoderRepository();

        await DefaultData.insertDefaultRecoder();
        // await DefaultData.insertLoadMoreRecoder();
        RecordBloc bloc = context.read<RecordBloc>();
        // bloc.loadRecord(operation: LoadType.refresh);
        // 查
        // List<Record> result = await repository.search();
        // print(result);

        //改
        // dao.update(Record(id: 5, title: "5", content: "57"));

        // 删
        // dao.deleteById(5);
      },
      child: const DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(blurRadius: 1, color: Colors.blue)]),
        child: CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage('assets/images/icon_head.webp'),
        ),
      ),
    );
  }
}