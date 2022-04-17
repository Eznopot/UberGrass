import 'package:flutter/material.dart';

import '../../constant/string.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  Widget drawerBodyItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback? onTap}) {
    return ListTile(
      title: Row(
        children: [
          Icon(
            icon,
            size: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Stack(children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.deepPurple,
                  ]),
            ),
          ),
          const Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text(DrawerTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ))),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          createDrawerHeader(),
          const Divider(),
        ],
      ),
    );
  }
}
