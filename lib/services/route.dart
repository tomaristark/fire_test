// enum PageType {homePage,detailPage,settingPage,indexPage}

// sealed class PageType{}
//
// class Home extends PageType{}
// class Detail extends PageType{}
// class Setting extends PageType{}
// class Index extends PageType{}
//
// class NotificationRoute{
//   static void route(PageType pageType){
//       switch(pageType){
//         case Home():
//           print('home');
//           break;
//         case Detail():
//          print('detail');
//         case Setting():
//           print('Setting');
//         case Index():
//           print('index');
//       }
//   }
// }


import 'package:flutter/material.dart';

import '../main.dart';
import '../pages/detail_page.dart';
import '../pages/home_page.dart';
import '../pages/setting_page.dart';

enum PageType {homePage,detailPage,settingPage}
class NotificationRoute{
  static void route(String type){
    if(type == PageType.homePage.name){
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_)=>const HomePage()));

    }else if(type ==PageType.detailPage.name){
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_)=> const DetailPage()));

    }else if(type == PageType.settingPage.name){
      MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (_)=> const SettingPage()));
    }
  }
}