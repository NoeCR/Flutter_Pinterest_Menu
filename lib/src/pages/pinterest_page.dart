import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

import '../classes/pinterest_button.class.dart';
import '../providers/menu.provider.dart';
import '../widgets/pinterest_menu.dart';

class PinterestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new MenuProvider(),
      child: Scaffold(
        body: Stack(
          children: [
            PinterestGrid(),
            _PinterestMenuLocation(),
          ],
        ),
      ),
    );
  }
}

class _PinterestMenuLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final display = Provider.of<MenuProvider>(context).display;
    return Positioned(
      bottom: 30,
      child: Container(
        width: widthScreen,
        child: Align(
          child: PinterestMenu(
            display: display,
            items: [
              PinterestButton(
                  icon: Icons.pie_chart,
                  onPressed: () {
                    print('Icon pie_chart');
                  }),
              PinterestButton(
                  icon: Icons.search,
                  onPressed: () {
                    print('Icon search');
                  }),
              PinterestButton(
                  icon: Icons.notifications,
                  onPressed: () {
                    print('Icon notifications');
                  }),
              PinterestButton(
                  icon: Icons.supervised_user_circle,
                  onPressed: () {
                    print('Icon supervised_user_circle');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class PinterestGrid extends StatefulWidget {
  @override
  _PinterestGridState createState() => _PinterestGridState();
}

class _PinterestGridState extends State<PinterestGrid> {
  final List items = List.generate(200, (index) => index);
  ScrollController scrollController = ScrollController();
  double previousScroll = 0;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.offset > previousScroll && scrollController.offset > 50) {
        Provider.of<MenuProvider>(context, listen: false).display = false;
      } else {
        Provider.of<MenuProvider>(context, listen: false).display = true;
      }
      previousScroll = scrollController.offset;
    });

    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.countBuilder(
      controller: scrollController,
      crossAxisCount: 4,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) => _PinterestItem(index),
      staggeredTileBuilder: (int index) => new StaggeredTile.count(2, index.isEven ? 2 : 3),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}

class _PinterestItem extends StatelessWidget {
  final int index;

  _PinterestItem(this.index);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
      ),
      child: Center(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Text('$index'),
        ),
      ),
    );
  }
}
