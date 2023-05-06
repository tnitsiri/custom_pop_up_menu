# CustomPopupMenu

Wrap a widget with CustomPopupMenu, **Tap** or **Long Press** this widget, a popup menu would display in a **suitable** position. 

# Features

- Gesture: Tap/Long Press
- Fully customized menu: can set any style of menu, the common styles see: [example/lib/main.dart](https://github.com/malikwang/custom_pop_up_menu/blob/master/example/lib/main.dart). just impl the menuBuilder.
- preset two style of menu: gridview, listview ,in dark and light mode.
- Auto calculate the position of menu, also supports manual adjustment.
- Fix the bug of can't hide menu in original lib.

# Demo

Using this package, you are free to build similar popup menu in WeChat.

<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/malikwang/custom_pop_up_menu/master/images/1.png">
                    <img src="https://raw.githubusercontent.com/malikwang/custom_pop_up_menu/master/images/1.png" width="200"/>
                </a>
            </td>            
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/malikwang/custom_pop_up_menu/master/images/2.png">
                    <img src="https://raw.githubusercontent.com/malikwang/custom_pop_up_menu/master/images/2.png" width="200"/>
                </a>
            </td>  
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/malikwang/custom_pop_up_menu/master/images/3.png">
                    <img src="https://raw.githubusercontent.com/malikwang/custom_pop_up_menu/master/images/3.png" width="200"/>
                </a>
            </td>  
        </tr>
    </table>
</div>






# preset style:

```dart
  menuBuilder: (){
             // return _buildLongPressMenu(menuController);
              return GridViewPopMenuLight(menuItems: menuItems, dataObj: message.content,controller: menuController,);
            },

 menuBuilder: () => ListViewPopMenuLight(menuItems: menuItems, dataObj: "添加按钮", controller: _controller),
```

![image-20230506153155200](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac3/image-20230506153155200.png)

![image-20230506153310655](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac3/image-20230506153310655.png)

![image-20230506151741109](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac3/image-20230506151741109.png)

![image-20230506153505200](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac3/image-20230506153505200.png)

![image-20230506152758820](https://cdn.jsdelivr.net/gh/shuiniuhss/myimages@main/imagemac3/image-20230506152758820.png)





## QuickPopUpMenu:

> Recommend to use this api

```dart
 QuickPopUpMenu({Key? key,
     required this.child,
     required this.menuItems,
     required this.dataObj,
     this.darkMode,
     this.pressType,
     this.useGridView,
     this.showArrow,
   })
```

it's just a quick wrap:

```dart
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
```

# usage sample:

```dart
QuickPopUpMenu(
            child: Text(message.content),
            pressType: PressType.longPress,
            menuItems:menuItems,
            useGridView: true,
            dataObj: message.content,
          )
```

# bug fix in original lib

Can not close menu when call controller.hideMenu() when use the popmenu in listview/gridview/scorllview, because the controller changes when scoll/reuse the item.

so we have to pass the event throught different controller:

[custom_pop_up_menu.dart](https://github.com/skyNet2017/custom_pop_up_menu/blob/master/lib/src/custom_pop_up_menu.dart)

```dart
  _updateView() {
    //debugPrint("_updateView()--->_controller-"+_controller.toString()+"@"+_controller.hashCode.toString()
     //   +", widget.controller: "+ widget.controller.toString()+"@"+widget.controller.hashCode.toString());
//_updateView()--->_controller-Instance of 'CustomPopupMenuController'@968634764, widget.controller: Instance of 'CustomPopupMenuController'@1068823743
    if(widget.controller != null && widget.controller != _controller){

      if(!widget.controller!.hasListeners){
        debugPrint("_updateView()--->widget.controller!.addListener,pass the outer listener event to the inner listener");
        widget.controller!.addListener(() {
          _controller!.toggleMenu();
        });
      }

    }

    bool menuIsShowing = _controller?.menuIsShowing ?? false;
    widget.menuOnChange?.call(menuIsShowing);
    if (menuIsShowing) {
      _showMenu();
    } else {
      _hideMenu();
    }

  }
```

