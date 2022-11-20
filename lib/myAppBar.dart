import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(35);

  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Color(0xff122c45), //change your color here
      ),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0, top: 8),
            child: GestureDetector(
              onTap: () {
              },
              child: const Icon(
                MdiIcons.settingsHelper,
                color: Color(0xff222c45),
                size: 26.0,
              ),
            )),
      ],
    );
  }
}


class MyAppBarBack extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: const IconThemeData(
        color: Colors.black, //change your color here
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(35);
}