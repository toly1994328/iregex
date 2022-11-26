import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

import '../views/record/bloc/record_bloc.dart';
import '../repository/impl/db/helper/default_data.dart';
import 'match/bloc/bloc.dart';
import 'match/bloc/state.dart';

class ContentTextPanel extends StatelessWidget {
  const ContentTextPanel({super.key});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: BlocBuilder<MatchBloc, MatchState>(
          builder: (_, state) {
            if(state.content.isEmpty){
              return const EmptyContent();
            }
            return Text.rich(state.inlineSpan);
          },
        ),
      ),
    );
  }
}

class EmptyContent extends StatelessWidget {
  const EmptyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Icon(
            TolyIcon.icon_regex,
            size: 64,
            color: Theme.of(context).primaryColor,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            "Welcome To Flutter Regexpo",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Color(
                  0xff6E6E6E,
                )),
          ),
          const SizedBox(
            height: 16,
          ),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Theme.of(context).primaryColor)),
              onPressed: () => insertTestData(context),
              child: const Text('导入测试数据')),
          const Spacer(),
          const Text(
            "Powered by 张风捷特烈 @2022",
            style: TextStyle(
                fontSize: 12,
                color: Color(
                  0xff6E6E6E,
                )),
          )
        ],
      ),
    );
  }

  void insertTestData(BuildContext context) async{
    await DefaultData.insertDefaultRecoder();
    RecordBloc bloc = context.read<RecordBloc>();
    bloc.loadRecord(operation: LoadType.refresh);
  }
}
