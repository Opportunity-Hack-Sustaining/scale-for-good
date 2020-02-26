/*
Code built off of Flutter's example of writing to files, which can be found at:
https://flutter.dev/docs/cookbook/persistence/reading-writing-files
*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import './Donation.dart';

class LocalStorage {

  static List <Donation> _donations;

  Future<void> init() async {
    if(_donations == null){
      _donations = new List<Donation>();
      String entries = await _readDonations();
      if (entries == "empty"){
        final file = await _localFile;
        file.writeAsString("[]");
      }
      else {
        final parsed = jsonDecode(entries).cast<Map<String, dynamic>>();
        _donations = parsed.map<Donation>((json) => Donation.fromJson(json)).toList();
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/donations.json');
  }

  Future<String> _readDonations() async {
    try {
      final file = await _localFile;
      String donations = await file.readAsString();
      return donations;
    }
    on FileSystemException {
      // If file is not found, return "empty".
      return "empty";
    }
  }

  Future<bool> writeDonation(Donation donation) async {
    print(donation.donatedBy);
    try {
      final file = await _localFile;
      _donations.add(donation);
      String donos = jsonEncode(_donations);
      file.writeAsString('$donos');
      donos = await _readDonations();
      print(donos);
      return true;
    } catch (e){
      print(e.toString());
      return false;
    }
  }

  List<Donation> getDonationsList() {
    return _donations;
  }
}