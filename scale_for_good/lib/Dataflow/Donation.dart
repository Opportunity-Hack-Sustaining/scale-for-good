import 'dart:convert';

class Donation{
  DateTime date;
  double weight;
  String donatedBy;
  String description;
  String email;
  bool sent;

  Donation(this.weight, this.donatedBy, [this.description, this.email]) {
    date = DateTime.now();
    sent = false;
  }

  Donation.fromJson(String jsonString) {
    Map<String, dynamic> dono = jsonDecode(jsonString);
    date = dono["date"];
    weight = dono["weight"];
    donatedBy = dono["donatedBy"];
    description = dono["description"];
    email = dono["email"];
    sent = dono["sent"];
  }

  String getJson(){
    return jsonEncode(this);
  }
}
