import 'package:flutter/material.dart';

class PaymentModel {
  String paymentName;
  String paymentLogo;
  Color paymentColor;
  String paymentNumber;
  bool isSelected;

  PaymentModel({
    required this.paymentName,
    required this.paymentLogo,
    required this.paymentColor,
    required this.isSelected,
    required this.paymentNumber,
  });
}

List<PaymentModel> paymentData = [
  PaymentModel(
    paymentName: 'ABA',
    paymentLogo: 'images/ABA.png',
    paymentColor: Colors.blue,
    paymentNumber: '**** **** **** 1234',
    isSelected: false,
  ),
  PaymentModel(
    paymentName: 'ACELEDA',
    paymentLogo: 'images/Aceleda.png',
    paymentColor: Colors.deepPurple,
    paymentNumber: '**** **** **** 5678',
    isSelected: false,
  ),
  PaymentModel(
    paymentName: 'Master Card',
    paymentLogo: 'images/MasterCard.png',
    paymentNumber: '**** **** **** 9999',
    paymentColor: Colors.red,
    isSelected: false,
  ),
  PaymentModel(
    paymentName: 'Paypal',
    paymentLogo: 'images/Paypal.png',
    paymentNumber: '**** **** **** 1111',
    paymentColor: Colors.cyan,
    isSelected: false,
  ),
];