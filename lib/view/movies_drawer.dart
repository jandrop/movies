import 'package:flutter/material.dart';

class MoviesDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Material(),
          ),
          ListTile(
            title: Text("Movies"),
            trailing: Icon(Icons.movie),
          ),
          Divider(
            height: 5.0,
          ),
          ListTile(
            title: Text("Television"),
            trailing: Icon(Icons.tv),
          ),
          Divider(
            height: 5.0,
          ),
          ListTile(
            title: Text("Exit"),
            trailing: Icon(Icons.exit_to_app),
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
