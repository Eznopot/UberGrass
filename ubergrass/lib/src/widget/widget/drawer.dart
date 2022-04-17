import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key, required this.context}) : super(key: key);

  BuildContext context;

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
          Positioned(
              bottom: 12.0,
              left: 16.0,
              child: Text(AppLocalizations.of(context)!.drawerTitle,
                  style: const TextStyle(
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
