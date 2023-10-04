import 'package:flutter/material.dart';

class Transaction {
  final IconData icon;
  final String title;
  final String date;
  final String amount;

  Transaction({
    required this.icon,
    required this.title,
    required this.date,
    required this.amount,
  });
}
