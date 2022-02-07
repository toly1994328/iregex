import 'dart:convert';

import 'model/reg_test_item.dart';

main(){
  String src = r"""
  [
  {
    "title":"中国地域",
    "subtitle": "测试数字正则匹配",
    "recommend": ["\\d","\\d+","(\\d+\\.\\d+)|(\\d+)"],
    "content":"中国陆地面积约960万平方千米，东部和南部大陆海岸线1.8万多千米，内海和边海的水域面积约470多万平方千米。海域分布有大小岛屿7600多个，其中台湾岛最大，面积35798平方千米 。中国同14国接壤，与8国海上相邻。省级行政区划为23个省、5个自治区、4个直辖市、2个特别行政区。"
  },
  {
    "title":"中国动物资源",
    "subtitle": "测试小数正则匹配",
    "recommend": ["\\d+\\.\\d+"],
    "content":"中国是世界上动物资源最为丰富的国家之一。据统计，中国陆栖脊椎动物约有2070种，占世界陆栖脊椎动物的9.8%。其中鸟类1170多种、兽类400多种、两栖类184种，分别占世界同类动物的13.5%、11.3%和7.3%。"
  },
  {
    "title":"2008北京奥运",
    "subtitle": "测试日期、首尾位置正则匹配",
    "recommend": ["\\d{1,2}月\\d{1,2}日","^\\d{1,2}月\\d{1,2}日","。$"],
    "content":"2008年上半年，奥运场馆测试赛陆续进行，包括手球国际邀请赛、举重中国公开赛、轮椅篮球国际邀请赛等各项赛事。\n3月24日，希腊赫拉神庙遗址，北京奥运会圣火取火成功。\n3月31日，奥林匹克圣火抵达中国首都北京。中共中央总书记、国家主席胡锦涛在仪式上亲手点燃圣火盆，并宣布北京2008年奥运会火炬接力开始。\n4月2日，北京奥运会火炬接力第一站传递活动在哈萨克斯坦阿拉木图举行。\n5月4日，奥运圣火从中国三亚启程，开始境内传递。5月8日，北京奥运圣火顺利登上世界最高峰珠穆朗玛峰。\n7月27日，位于奥林匹克公园内的奥运村开村。\n8月8日，点燃北京奥运会主火炬，奥运会开幕。"
  },
  {
    "title":"I Have A Dream",
    "subtitle": "测试单词边距、正则位置的正则匹配",
    "recommend": ["\\ba","\\Ba","h(?=a)","(?<=a)l","h(?!a)","(?<![ap])l"],
    "content":"I have a dream that one day every valley shall be exalted, and every hill and mountain shall be made low, the rough places will be made plain, and the crooked places will be made straight; \"and the glory of the Lord shall be revealed and all flesh shall see it together.\""
  }
]""";
 var a =json.decode(src).map<RegTestItem>((e)=>RegTestItem.fromJson((e))).toList();
print(a);
}