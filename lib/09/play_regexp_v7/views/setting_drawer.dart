import 'package:flutter/material.dart';
import 'package:regexp/09/play_regexp_v7/model/regexp_config.dart';
import 'package:regexp/app/iconfont/toly_icon.dart';

class SettingDrawer extends StatelessWidget {

  final  ValueNotifier<RegExpConfig> regExpConfig;

  const SettingDrawer({Key? key,required this.regExpConfig}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // color: color.withAlpha(33),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UnitDrawerHeader(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0,top: 5,bottom: 15),
            child: Text('正则表达式配置项',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
          ),
          ValueListenableBuilder(
              child: Icon(
                TolyIcon.icon_multiLine,
                color: Theme.of(context).primaryColor,
              ),
              valueListenable: regExpConfig, builder: (_,RegExpConfig config,child ){
           return SwitchListTile(
              value: config.multiLine,
              secondary:child,
              title: const Text('多行匹配'),
              onChanged: (value) {
                regExpConfig.value = config.copyWith(
                  multiLine:  value
                );
              },
            );
          }),
          ValueListenableBuilder(
              child: Icon(
                TolyIcon.icon_caseSensitive,
                color: Theme.of(context).primaryColor,
              ),
              valueListenable: regExpConfig, builder: (_,RegExpConfig config,child ){
            return SwitchListTile(
              value: config.caseSensitive,
              secondary:child,
              title: const Text('区分大小写'),
              onChanged: (value) {
                regExpConfig.value = config.copyWith(
                    caseSensitive:  value
                );
              },
            );
          }),

          ValueListenableBuilder(
              child: Icon(
                TolyIcon.icon_dot_all,
                color: Theme.of(context).primaryColor,
              ),
              valueListenable: regExpConfig, builder: (_,RegExpConfig config,child ){
            return SwitchListTile(
              value: config.dotAll,
              secondary:child,
              title: const Text('点全匹配'),
              onChanged: (value) {
                regExpConfig.value = config.copyWith(
                    dotAll:  value
                );
              },
            );
          }),
          ValueListenableBuilder(
              child: Icon(
                TolyIcon.icon_unicode,
                color: Theme.of(context).primaryColor,
              ),
              valueListenable: regExpConfig, builder: (_,RegExpConfig config,child ){
            return SwitchListTile(
              value: config.unicode,
              secondary:child,
              title: const Text('unicode 码'),
              onChanged: (value) {
                regExpConfig.value = config.copyWith(
                    unicode:  value
                );
              },
            );
          }),
        ]),
      ),
    );
  }


}

class UnitDrawerHeader extends StatelessWidget {
  final Color color;

  const UnitDrawerHeader({this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.only(top: 10, left: 15),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/draw_bg3.webp'),
              fit: BoxFit.cover),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(blurRadius: 1, color: Colors.blue)]),
                padding: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/icon_head.webp'),
                ),
              ),
              // FlutterLogo(
              //   size: 35,
              // ),
              Text(
                'RegExplorer',
                style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
                  Shadow(
                      color: Colors.black, offset: Offset(1, 1), blurRadius: 3)
                ]),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text(
              '基于 Flutter 框架实现的， 全平台正则表达式交互学习应用。',
              style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                Shadow(color: color, offset: Offset(.5, .5), blurRadius: 1)
              ]),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Spacer(
                flex: 5,
              ),
              Text(
                '——Powered By 张风捷特烈',
                style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                  Shadow(
                      color: Colors.orangeAccent,
                      offset: Offset(.5, .5),
                      blurRadius: 1)
                ]),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
