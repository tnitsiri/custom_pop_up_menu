import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_pop_up_menu.dart';
import 'pop_menu_item_model.dart';

class ListViewPopMenu extends StatelessWidget {

  List<PopMenuItemModel> menuItems;
  CustomPopupMenuController controller;
  dynamic dataObj;
   ListViewPopMenu({Key? key,
     required this.menuItems,
     required this.dataObj,
     required this.controller})
       : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: const Color(0xFF4C4C4C),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems
                .map(
                  (item) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //debugPrint("onTap-->"+dataObj.toString());
                  controller.hideMenu();
                  item.callback.call(dataObj);
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        item.icon,
                        size: 15,
                        color: Colors.white,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding:
                          EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ListViewPopMenuLight extends StatelessWidget {

  List<PopMenuItemModel> menuItems;
  CustomPopupMenuController controller;
  dynamic dataObj;
  ListViewPopMenuLight({Key? key,
    required this.menuItems,
    required this.dataObj,
    required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 5,
          )]
        ),
        child: IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: menuItems
                .map(
                  (item) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  //debugPrint("onTap-->"+dataObj.toString());
                  controller.hideMenu();
                  item.callback.call(dataObj);
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        item.icon,
                        size: 15,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          padding:
                          EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
    );
  }
}


