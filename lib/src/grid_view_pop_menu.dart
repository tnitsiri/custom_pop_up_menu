import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_pop_up_menu.dart';
import 'pop_menu_item_model.dart';

class GridViewPopMenu extends StatelessWidget {
  List<PopMenuItemModel> menuItems;
  CustomPopupMenuController controller;
  dynamic dataObj;
   GridViewPopMenu({Key? key,
     required this.menuItems,
     required this.dataObj,
     required this.controller})
       : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 5,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: menuItems
              .map((item) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              //debugPrint("click-->"+item.title);
              //menuController.menuIsShowing = false;
             // debugPrint("click--> menuController: "+controller.hashCode.toString());
              controller.hideMenu();
              item.callback.call(dataObj);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  item.icon,
                  size: 20,
                  color: Colors.white,
                ),
                Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    item.title,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          ))
              .toList(),
        ),
      ),
    );
  }
}
