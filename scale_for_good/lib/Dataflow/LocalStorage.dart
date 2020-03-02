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
      String entries = await _readFile();
      if (entries == "empty"){
        _writeFile();
        print(_readFile());
      }
      else {
        final parsed = jsonDecode(entries).cast<Map<String, dynamic>>();
        _donations = parsed.map<Donation>((json) =>
            Donation.fromJson(json)).toList();
      }
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    print (directory);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/donations.json');
  }

  Future<String> _readFile() async {
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

  Future<bool> _writeFile() async {
    try {
      final file = await _localFile;
      file.writeAsString(jsonEncode(_donations));
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> writeDonation(Donation donation) async {
      _donations.add(donation);
      bool writeSuccessful = await _writeFile();
      if (!writeSuccessful){
        _donations.removeLast();
      }
      return writeSuccessful;
  }

  Future<bool> deleteDonation(int index) async {}

  List<Donation> getDonationsList() {
    return _donations;
  }
}