import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scale_for_good/Dataflow/Donation.dart';
import 'package:scale_for_good/Dataflow/LocalStorage.dart';
import 'package:scale_for_good/Pages/History/EntryRow.dart';
import 'package:scale_for_good/Pages/Navigation/HamburgerMenu.dart';
import 'package:scale_for_good/Pages/Settings/SettingsPage.dart';
import 'package:scale_for_good/Pages/Home/HomePage.dart';

class HistoryPage extends StatefulWidget {

  final LocalStorage storage;
  final String title;

  HistoryPage({Key key, this.title, @required this.storage}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();

}

class _HistoryPageState extends State<HistoryPage> {

  List<Donation> donations;

  @override
  Widget build(BuildContext context) {
    donations = widget.storage.getDonationsList();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title)
        ),

        drawer: HamburgerMenu(),

        body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(10.0),

          child: ListView.builder(
            itemCount: donations.length,
            itemBuilder: (BuildContext context, int index){
            return EntryRow(donations[index], index);
            }
          ),
        )
      )
    );
  }

}