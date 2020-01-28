import 'Donation.dart';

class AwsConnect{

  bool connect(){
    //Establish connection
    return true;
  }

  bool sendDonation(Donation d){
    //Sends Donation d
    d.sent = true;
    return true;
  }
}