import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    Payment({
        required this.date,
        required this.description,
        required this.type,
    });

    String date;
    String description;
    String type;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        date: json["date"],
        description: json["description"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "date": date,
        "description": description,
        "type": type,
    };
}


