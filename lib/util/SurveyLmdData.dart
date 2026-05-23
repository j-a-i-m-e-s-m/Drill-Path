import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; 

class SurveyLmdData extends ChangeNotifier {
  List<FlSpot> _puntosSurveyLmd = [];

  List<FlSpot> get puntosSurveyLmd => _puntosSurveyLmd;

  void updateData(List<double> survey, List<double> lmd) {
    _puntosSurveyLmd = [];
    for (int i = 0; i < survey.length; i++) {
      _puntosSurveyLmd.add(FlSpot(survey[i], lmd[i]));
    }
    notifyListeners(); // Notifica a los widgets que escuchan este estado
  }
}