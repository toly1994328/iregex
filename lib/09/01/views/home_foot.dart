import 'package:flutter/material.dart';

class FootBar extends StatelessWidget {
  const FootBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: const Color(0xffF2F2F2),
      child: Row(
        children: const[
          RegexConfigTools(),
          Spacer(),
          ResultShower(),
        ],
      ),
    );
  }
}

class ResultShower extends StatelessWidget {


  const ResultShower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      children: [
        Text('规则正常',style: TextStyle(fontSize: 11,color: Colors.blue),),
        Text('match: 0',style: TextStyle(fontSize: 11,color: Colors.blue),),
        Text('group: 0',style: TextStyle(fontSize: 11,color: Colors.blue),),
      ],
    );
  }
}

class RegexConfigTools extends StatelessWidget {
  final bool multiLine;
  final bool caseSensitive;
  final bool unicode;
  final bool dotAll;



   const RegexConfigTools({Key? key,
     this.multiLine = false,
     this.caseSensitive = true,
     this.unicode = false,
     this.dotAll = false
   }) : super(key: key);

  final List<String> configInfo = const [
    'multiLine',
    'caseSensitive',
    'dotAll',
    'unicode',
  ];
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Wrap(
      children: configInfo.asMap().keys.map((int index) {
        bool active = false;
        if (index == 0) {
          active = multiLine;
        }
        if (index == 1) {
          active = caseSensitive;
        }
        if (index == 2) {
          active = unicode;
        }
        if (index == 3) {
          active = unicode;
        }
        TextStyle style =
        TextStyle(fontSize: 11, color: Colors.grey.withOpacity(0.8),height: 1);
        TextStyle activeStyle =
        TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color,height: 1);
        return GestureDetector(
          onTap: () {
            // if (index == 0) {
            //   regExpConfig.value = value.copyWith(multiLine: !value.multiLine);
            // }
            // if (index == 1) {
            //   regExpConfig.value =
            //       value.copyWith(caseSensitive: !value.caseSensitive);
            // }
            // if (index == 2) {
            //   regExpConfig.value = value.copyWith(dotAll: !value.dotAll);
            // }
            // if (index == 3) {
            //   active = value.unicode;
            //   regExpConfig.value = value.copyWith(unicode: !value.unicode);
            // }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4),
            child: Text(
              configInfo[index],
              style: active ? activeStyle : style,
            ),
          ),
        );
      }).toList(),
    );
  }




}
