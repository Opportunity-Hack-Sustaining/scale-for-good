import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:scale_for_good/Dataflow/Donation.dart';

class EntryRow extends StatelessWidget {

  int index;
  String date, donator, description, email;
  double weight;
  DateFormat dateFormat = new DateFormat.yMMMd();

  EntryRow (Donation donation, int index){
    this.index = index;
    date = dateFormat.format(donation.date);
    donator = donation.donatedBy;
    description = donation.description;
    email = donation.email;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Text(
              date,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis
            ),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey)
              )
            )
          )
        ),
        Expanded(
          child: Container(
            child: Text(
              weight.toStringAsFixed(2),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis
            ),
            decoration: const BoxDecoration(
               border: Border(
                 left: BorderSide(width: 1, color: Colors.grey),
                 right: BorderSide(width: 1, color: Colors.grey),
                 bottom: BorderSide(width: 1, color: Colors.grey)
               )
            )
          )
        ),
        Expanded(
          child: Container(
            child: Text(
              description,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis
            ),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey)
              )
            )
          )
        ),
        Expanded(
          child: Container(
            child: Text(
              donator,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis
            ),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Colors.grey),
                right: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey)
              )
            )
          )
        ),
        Expanded(
          child: Container(
            child: Text(
              email,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis
            ),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(width: 1, color: Colors.grey),
                bottom: BorderSide(width: 1, color: Colors.grey)
              )
            )
          )
        ),
      ],
    );
  }

}