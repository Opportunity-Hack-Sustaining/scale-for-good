import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scale_for_good/Pages/History/HistoryPage.dart';
import 'package:scale_for_good/Pages/Home/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SettingsPage.dart';

class SignInPage extends StatefulWidget {
  //final LocalStorage storage;
  final String title;


  SignInPage({Key key, this.title}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  //toggle for weight calc. First is lbs and second is kilos
  List<bool> weightList = [false,true];
  String _username;
  String _password;
  String _databaseName;
  @override
  Widget build(BuildContext context) {

    Widget userNameInput = Container(
      padding: const EdgeInsets.only(left:32, right:32, top:12, bottom:12),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Username:",
        ),
        onChanged: (text){
          setState(() {
            _username = text;
          });
        },
      ),
    );

    Widget passwordInput = Container(
      padding: const EdgeInsets.only(left:32, right:32, top:12, bottom:12),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Password:",
        ),
        onChanged: (text){
          setState(() {
            _username = text;
          });
        },
      ),
    );

    Widget dbNameInput = Container(
      padding: const EdgeInsets.only(left:32, right:32, top:12, bottom:50),
      child: TextField(
        decoration: InputDecoration(
          labelText: "Database name:",
        ),
        onChanged: (text){
          setState(() {
            _username = text;
          });
        },
      ),
    );

    Widget discovDevices = Container(
      padding: const EdgeInsets.only(left:32, right:32, top:12, bottom:12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Scale name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildButtonColumn(Colors.blue, Icons.add, 'Add'),
          Text('   '),
          /*3*/
        ],
      ),
    );

    Widget confirm = SizedBox(
      width: 100.0,
      height: 100.0,
      child: new RaisedButton(
        child: new Text('SIGN IN'),
        onPressed: _dbConnect,
      ),
    );


    //Begin main settings
    Widget signInTitle = Container(

      padding: const EdgeInsets.only(left:32),
      child: Text(
        'Sign In Credentials',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );



    return MaterialApp(
      title: 'Sign In',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sign In'),
        ),

        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                  title: new Text("Sign In"),
                  trailing: new Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => SignInPage(title: 'Sign In')));
                  }
              ),
              new Divider(),
              new ListTile(
                  title: new Text("Home Page"),
                  trailing: new Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => HomePage(title: 'Home Page')));
                  }
              ),
              new ListTile(
                  title: new Text("Settings Page"),
                  trailing: new Icon(Icons.settings),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => SettingsPage(title: "Settings")));
                  }
              ),
              new ListTile(
                  title: new Text("History"),
                  trailing: new Icon(Icons.history),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => HistoryPage(title: "History")));
                  }
              ),
              new Divider(),
              new ListTile(
                title: new Text("Close"),
                trailing: new Icon(Icons.cancel),
                onTap: () => Navigator.of(context).pop(),
              )

            ],
          ),
        ),

        body: ListView(

          padding: const EdgeInsets.only(top:30),
          children: [
            signInTitle,
            userNameInput,
            passwordInput,
            dbNameInput,
            confirm
          ],
        ),
      ),
    );
  }
  void _dbConnect() {
    //Implement connection here
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }




}