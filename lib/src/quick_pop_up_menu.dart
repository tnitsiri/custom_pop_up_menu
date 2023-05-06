
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'custom_pop_up_menu.dart';
import 'grid_view_pop_menu.dart';
import 'list_view_pop_menu.dart';
import 'pop_menu_item_model.dart';

class QuickPopUpMenu extends StatelessWidget {

  Widget child;
  bool? darkMode;
  bool? useGridView;
  bool? showArrow;
  List<PopMenuItemModel> menuItems;
  dynamic dataObj;
   PressType? pressType;

  final CustomPopupMenuController menuController = CustomPopupMenuController();
   QuickPopUpMenu({Key? key,
     required this.child,
     required this.menuItems,
     required this.dataObj,
     this.darkMode,
     this.pressType,
     this.useGridView,
     this.showArrow,
   })
       : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPopupMenu(
      child: child,
      menuBuilder: (){
        if(useGridView??false){
          if(darkMode ??false){
            return GridViewPopMenu(menuItems: menuItems, dataObj: dataObj,controller: menuController,);
          }else{
            return GridViewPopMenuLight(menuItems: menuItems, dataObj: dataObj,controller: menuController,);
          }
        }else{
          if(darkMode ?? false){
            return ListViewPopMenu(menuItems: menuItems, dataObj: dataObj,controller: menuController,);
          }else{
            return ListViewPopMenuLight(menuItems: menuItems, dataObj: dataObj,controller: menuController,);
          }
        }
      },
      controller: menuController,
      barrierColor: Colors.transparent,
      showArrow: showArrow??false,
      pressType: pressType??PressType.singleClick,
      verticalMargin: 0,
    );
  }
}
