import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../classes/pinterest_button.class.dart';
import '../providers/menu.provider.dart';

class PinterestMenu extends StatelessWidget {
  final bool display;
  final List<PinterestButton> items;

  PinterestMenu({required this.display, required this.items});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider(
        create: (_) => new MenuProvider(),
        child: AnimatedOpacity(
          opacity: display ? 1 : 0,
          duration: Duration(milliseconds: 200),
          child: _PinterestMenuBackground(
            child: _MenuItems(items),
          ),
        ),
      ),
    );
  }
}

class _PinterestMenuBackground extends StatelessWidget {
  final Widget child;

  _PinterestMenuBackground({required this.child});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Provider.of<MenuProvider>(context).backgroundColor;

    return Container(
      child: this.child,
      width: 250,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 10,
            spreadRadius: -5,
          )
        ],
      ),
    );
  }
}

class _MenuItems extends StatelessWidget {
  final List<PinterestButton> menuItems;

  _MenuItems(this.menuItems);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(menuItems.length, (index) => _PinterestMenuButton(index, menuItems[index])),
    );
  }
}

class _PinterestMenuButton extends StatelessWidget {
  final int index;
  final PinterestButton item;

  _PinterestMenuButton(this.index, this.item);

  @override
  Widget build(BuildContext context) {
    final selectedItem = Provider.of<MenuProvider>(context).selectedItem;
    final activeColor = Provider.of<MenuProvider>(context).activeColor;
    final secondaryColor = Provider.of<MenuProvider>(context).secondaryColor;
    final bool isSelected = selectedItem == index;

    return GestureDetector(
      onTap: () {
        Provider.of<MenuProvider>(context, listen: false).selectedItem = index;
        item.onPressed();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        child: Icon(
          item.icon,
          size: isSelected ? 35 : 25,
          color: isSelected ? activeColor : secondaryColor,
        ),
      ),
    );
  }
}

// class MenuModel with ChangeNotifier {
//   int _selectedItem = 0;

//   int get selectedItem => this._selectedItem;

//   set selectedItem(int index) {
//     this._selectedItem = index;
//     notifyListeners();
//   }
// }
