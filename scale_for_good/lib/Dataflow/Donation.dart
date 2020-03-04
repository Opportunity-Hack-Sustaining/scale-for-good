class Donation{
  DateTime date;
  double weight;
  String donatedBy;
  String description;
  String email;

  Donation({this.date, this.weight, this.donatedBy, this.description, this.email});

  factory Donation.fromJson(Map<String, dynamic> json) {
    return Donation(
      date: DateTime.parse(json['date']),
      weight: json['weight'] as double,
      donatedBy: json['donatedBy'] as String,
      description: json['description'] as String,
      email: json['email'] as String
    );
  }

  Map<String, dynamic> toJson(){
    Map<String, dynamic> jsonDono = {
      "date" : date.toString(),
      "weight" : weight,
      "donatedBy" : donatedBy,
      "description" : description,
      "email" : email
    };
    return jsonDono;
  }
}
