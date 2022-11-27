import 'package:flutter/material.dart';

import '../../../components/single_filter/rrect_check.dart';
import '../../../components/single_filter/single_filter.dart';
import '../../../repository/impl/db/model/link_regex.dart';
import '../bloc/link_regex_bloc.dart';
import '../bloc/link_regex_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoadedRegexPanel extends StatelessWidget {
  final LoadedLinkRegexState state;

  const LoadedRegexPanel({super.key,required this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      itemExtent: 28,
      children: state.regexes.map((LinkRegex regex) {
        bool selected = regex.id == state.activeLinkRegexId;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: ()=> _onSelect(context,regex),
          child: Row(
            children: [
              RRectCheck(
                inActiveColor: const Color(0xffB0B0B0),
                active: selected,
              ),
              const SizedBox(
                width: 8,
              ),
              Flexible(child: Text(regex.regex))
            ],
          ),
        );
      }).toList(),
    );
  }

  void _onSelect(BuildContext context,LinkRegex regex) {
    if(regex.id == state.activeLinkRegexId){
      context.read<LinkRegexBloc>().select(-1);

    }else{
      context.read<LinkRegexBloc>().select(regex.id);
    }
  }
}
