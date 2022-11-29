import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
const Map<int, ThemeMode> kAppThemeMap = {
  0: ThemeMode.light,
  1: ThemeMode.dark,
};

class AppConfig extends Equatable{
  /// 关联关系见 [kAppThemeMap]
  final int appThemeMode;

  const AppConfig({this.appThemeMode = 0});

  ThemeMode get themeMode=> kAppThemeMap[appThemeMode]!;

  AppConfig copyWith({int? appThemeMode}){
    return AppConfig(
        appThemeMode:appThemeMode??this.appThemeMode
    );
  }

  @override
  List<Object?> get props => [appThemeMode];
}
