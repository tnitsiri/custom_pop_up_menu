

import 'package:flutter/widgets.dart';

class PopMenuItemModel {
  String title;
  IconData? icon;
  Function( int index,dynamic data) callback;

  PopMenuItemModel({required this.title, this.icon,required this.callback});
}