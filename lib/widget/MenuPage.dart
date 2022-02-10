import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const home = MenuItem('Home');
  static const shop = MenuItem('Shop');
  static const all = <MenuItem>[home, shop];
}

class MenuItem {
  final String title;

  const MenuItem(this.title);
}

class MenuPage extends StatelessWidget {
  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  const MenuPage({Key key, this.currentItem, this.onSelectedItem}) : super(key: key);
  Widget buildMenuItem(MenuItem item)=> ListTileTheme(
    selectedColor: Colors.white,
    child: ListTile(
      selectedTileColor: Colors.black26,
      selected: currentItem==item,
      minLeadingWidth: 20,
      // leading: Icon(item.icon),
      title: Text(item.title),
      onTap: () => onSelectedItem(item),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(backgroundColor: Colors.indigo,
          body: SafeArea(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children:<Widget> [
               Spacer(),
               ...MenuItems.all.map(buildMenuItem).toList(),
               Spacer(flex:2)
             ],
           ),
          )),
    );

  }
}
