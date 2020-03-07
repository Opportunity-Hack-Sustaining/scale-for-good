import 'package:flutter/material.dart';
import 'package:scale_for_good/Dataflow/LocalStorage.dart';
import 'package:scale_for_good/Pages/History/HistoryPage.dart';
import 'package:scale_for_good/Pages/Home/HomePage.dart';
import 'package:scale_for_good/Pages/Settings/SettingsPage.dart';

class HamburgerMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: new ListView(
        children: <Widget>[
          new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => HomePage(
                      title: "Home Page",
                      storage: LocalStorage()
                    )
                ));
              }
          ),

          new ListTile(
              title: new Text("Settings"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => SettingsPage(
                      title: "Settings Page"
                    )
                ));
              }
          ),

          new ListTile(
              title: new Text("History"),
              trailing: new Icon(Icons.history),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => HistoryPage(
                        title: "History Page",
                        storage: LocalStorage()
                    )
                ));
              }
          ),

          new Divider(),

          new ListTile(
            title: new Text("Close"),
            trailing: new Icon(Icons.cancel),
            onTap: () => Navigator.of(context).pop(),
          )
        ]
      )
    );
  }

}
