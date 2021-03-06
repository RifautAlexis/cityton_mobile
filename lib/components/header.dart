import 'package:flutter/material.dart';
import 'package:cityton_mobile/constants/header.constants.dart';
import 'package:get/get.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final HeaderLeading leadingState;
  final String title;
  final bool resultOnBack;
  final List<IconButton> iconsAction;

  const Header(
      {Key key,
      @required this.leadingState,
      this.resultOnBack,
      @required this.title,
      this.iconsAction})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(50.0);

  @override
  Widget build(BuildContext context) {
    if (HeaderLeading.NO_LEADING == leadingState) {
      return AppBar(title: Text(title), actions: _buildActions());
    } else if (HeaderLeading.MENU == leadingState) {
      return AppBar(
          leading: _buildMenu(context),
          title: Text(title),
          actions: _buildActions());
    } else {
      return AppBar(
        leading: _buildBack(context),
        title: Text(title),
        actions: _buildActions(),
      );
    }
  }

  List<Widget> _buildActions() {
    List<Widget> widgets = List<Widget>();

    if (iconsAction != null) {

      iconsAction.forEach((IconButton iconsButton) => widgets.add(iconsButton));
    }
    
    return widgets;
  }

  Widget _buildMenu(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer());
  }

  Widget _buildBack(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => resultOnBack == null ? Get.back() : Get.back(result: resultOnBack),
    );
  }
}
