import 'package:flutter/cupertino.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:knet/screen/MapScreen.dart';
import 'package:knet/screen/MenuBarScreen.dart';
import 'package:knet/screen/auth_screen.dart';
import 'package:knet/screen/shop_screen.dart';
import 'package:knet/widget/MenuPage.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MenuItem currentItem = MenuItems.home;
  @override
  Widget build(BuildContext context) => ZoomDrawer(
        style: DrawerStyle.Style2,
        menuScreen: MenuPage(
          currentItem:currentItem,
          onSelectedItem:(item){
setState(() {
  currentItem=item;
});
ZoomDrawer.of(context).close();
          }
        ), mainScreen:getScreen());

  Widget getScreen() {
    switch(currentItem){
      case MenuItems.home:return MapScreen();
      case MenuItems.shop:return ShopScreen();
    }

  }
}
