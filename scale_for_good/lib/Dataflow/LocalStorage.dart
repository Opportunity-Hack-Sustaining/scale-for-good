/*
Code built off of FLutter's example of writing to files, which can be found at:
https://flutter.dev/docs/cookbook/persistence/reading-writing-files
 */

import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/donations.json');
  }

  Future<String> readDonations() async {
    try {
      final file = await _localFile;
      String donations = await file.readAsString();
      return donations;

    } catch (e) {
      // If encountering an error, return error message.
      return e.toString();
    }
  }

  Future<File> writeDonation(String donation) async {
    final file = await _localFile;
    print("donation written");
    return file.writeAsString('$donation');
  }
}