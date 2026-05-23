import 'package:flutter/material.dart';
class ScheduledModel {
  final String title;
  final String date;
  final IconData icon; // ✅ nuevo campo

  const ScheduledModel({
    required this.title,
    required this.date,
    this.icon = Icons.location_on, // ✅ valor por defecto
  });
}