import 'package:flutter/material.dart';

class DeliveryModel {
  String deliverName;
  String deleveryLogo;
  String duration;
  Color deliveryColor;
  bool isSelected;

  DeliveryModel({
    required this.deliverName,
    required this.deleveryLogo,
    required this.duration,
    required this.deliveryColor,
    required this.isSelected,
  });
}

List<DeliveryModel> deliveryData = [
  DeliveryModel(
    deliverName: 'Food Panda',
    deleveryLogo: 'images/FoodPanda.png',
    duration: '1-2 days',
    deliveryColor: Colors.pink,
    isSelected: false,
  ),
  DeliveryModel(
    deliverName: 'Nham24',
    deleveryLogo: 'images/Nham24.png',
    duration: '2-5 days',
    deliveryColor: Colors.teal,
    isSelected: false,
  ),
  DeliveryModel(
    deliverName: 'Wow Now',
    deleveryLogo: 'images/WowNow.png',
    duration: '3-5 days',
    deliveryColor: Colors.orange,
    isSelected: false,
  ),
];