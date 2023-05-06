import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class ChatModel {
  String content;
  bool isMe;

  ChatModel(this.content, {this.isMe = false});
}

/*class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}*/

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CustomPopupMenu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ChatModel> messages;
  late List<PopMenuItemModel> menuItems;
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  void initState() {
    messages = [
      ChatModel('在吗？'),
      ChatModel('咋了？找我有事吗？', isMe: true),
      ChatModel('没啥就像看看你在不在'),
      ChatModel('到底啥事你说啊，我还在工作呢', isMe: true),
      ChatModel('？', isMe: true),
      ChatModel('下面开始介绍Flutter'),
      ChatModel(
          'Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。'),
      ChatModel('就这？？？', isMe: true),
      ChatModel('在吗？'),
      ChatModel('咋了？找我有事吗？', isMe: true),
      ChatModel('没啥就像看看你在不在'),
      ChatModel('到底啥事你说啊，我还在工作呢', isMe: true),
      ChatModel('？', isMe: true),
      ChatModel('下面开始介绍Flutter'),
      ChatModel(
          'Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。'),
      ChatModel('就这？？？', isMe: true),
    ];
    menuItems = [
      //    PopMenuItemModel(title: '复制',icon: Icons.content_copy, callback: (int index, data) { debugPrint("data: "+data); }),
      PopMenuItemModel(title: '发起群聊',icon: Icons.chat_bubble, callback: ( data) { debugPrint("data: "+data); }),
      PopMenuItemModel(title: '添加朋友',icon: Icons.group_add, callback: ( data) { debugPrint("data: "+data); }),
      PopMenuItemModel(title: '扫一扫',icon: Icons.settings_overscan, callback: ( data) { debugPrint("data: "+data); }),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomPopupMenu'),
        actions: <Widget>[
          CustomPopupMenu(
            child: Container(
              child: Icon(Icons.add_circle_outline, color: Colors.white),
              padding: EdgeInsets.all(20),
            ),
            menuBuilder: () => ListViewPopMenu(menuItems: menuItems, dataObj: "添加按钮", controller: _controller),
            pressType: PressType.singleClick,
            verticalMargin: -10,
            controller: _controller,
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: Column(
                children: messages
                    .map(
                      (message) => MessageContent(
                        message,
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class MessageContent extends StatelessWidget {
  MessageContent(this.message);

  final CustomPopupMenuController menuController = CustomPopupMenuController();

  final ChatModel message;
  List<PopMenuItemModel> menuItems = [
    PopMenuItemModel(title: '复制',icon: Icons.content_copy, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '转发', icon:Icons.send, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '收藏', icon:Icons.collections, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '删除', icon:Icons.delete, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '多选', icon:Icons.playlist_add_check, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '引用', icon:Icons.format_quote, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '提醒', icon:Icons.add_alert, callback: ( data) { debugPrint("data: "+data); }),
    PopMenuItemModel(title: '搜一搜',icon: Icons.search, callback: ( data) { debugPrint("data: "+data); }),
  ];

  Widget _buildLongPressMenu(menuController) {
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
            onTap: (){
              debugPrint("click-->"+item.title);
              //menuController.menuIsShowing = false;
              debugPrint("click--> menuController: "+menuController.hashCode.toString());
              menuController.hideMenu();
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

  Widget _buildAvatar(bool isMe, double size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: isMe ? Colors.blueAccent : Colors.pinkAccent,
        width: size,
        height: size,
        child: Icon(
          isMe ? Icons.face : Icons.tag_faces,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMe = message.isMe;
    double avatarSize = 40;

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: isMe ? 0 : 10, left: isMe ? 10 : 0),
            child: CustomPopupMenu(
              child: _buildAvatar(isMe, avatarSize),
              menuBuilder: () => GestureDetector(
                child: _buildAvatar(isMe, 100),
                onLongPress: () {
                  debugPrint("onLongPress");
                },
                onTap: () {
                  debugPrint("onTap");
                },
              ),
              barrierColor: Colors.transparent,
              pressType: PressType.singleClick,
              arrowColor: isMe ? Colors.blueAccent : Colors.pinkAccent,
              position: PreferredPosition.top,

            ),
          ),
          CustomPopupMenu(
            child: Container(
              padding: EdgeInsets.all(10),
              constraints: BoxConstraints(maxWidth: 240, minHeight: avatarSize),
              decoration: BoxDecoration(
                color: isMe ? Color(0xff98e165) : Colors.white,
                borderRadius: BorderRadius.circular(3.0),
              ),
              child: Text(message.content),
            ),
            menuBuilder: (){
             // return _buildLongPressMenu(menuController);
              return GridViewPopMenu(menuItems: menuItems, dataObj: message.content,controller: menuController,);
            },
            controller: menuController,
            barrierColor: Colors.transparent,
            pressType: PressType.longPress,
          )
        ],
      ),
    );
  }
}
