import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';


class TrajectoryProvider with ChangeNotifier {
  Map<String, dynamic> _summaryData = {};
  List<FlSpot> _surveyLmdData = [];
  List<FlSpot> _scatterData = [];
  List<FlSpot> _vistHorData = [];
  List<Map<String, dynamic>> _tableData = [];
  String _tipoPozo = '';
  List<dynamic> _Az = [];
  List<dynamic> _inc = [];
  dynamic _Pvfci;
  dynamic _Dhfci;
  dynamic _Larca;
  dynamic _Larcb;
  dynamic _Ltan;
  dynamic _Pvfst;
  dynamic _Dhfst;
  dynamic _Pdfci;
  dynamic _Pdfst;
  dynamic _Pdfcd;
  dynamic _DH;
  dynamic _angmax;

  Map<String, dynamic> get summaryData => _summaryData;
  List<FlSpot> get surveyLmdData => _surveyLmdData;
  List<FlSpot> get scatterData => _scatterData;
  List<FlSpot> get vistHorData => _vistHorData;
  List<Map<String, dynamic>> get tableData => _tableData;
  String get tipoPozo => _tipoPozo;
  List<dynamic> get Az => _Az ?? [];
  List<dynamic> get inc => _inc ?? [];
  dynamic get Pvfci => _Pvfci;
  dynamic get Dhfci => _Dhfci;
  dynamic get Larca => _Larca;
  dynamic get Larcb => _Larcb;
  dynamic get Ltan => _Ltan;
  dynamic get Pvfst => _Pvfst;
  dynamic get Dhfst => _Dhfst;
  dynamic get Pdfci => _Pdfci;
  dynamic get Pdfst => _Pdfst;
  dynamic get Pdfcd => _Pdfcd;
  dynamic get DH => _DH;
  dynamic get angmax => _angmax;

  void updateTrajectoryData({
    required Map<String, dynamic> summary,
    required List<FlSpot> surveyLmd,
    required List<FlSpot> scatter,
    required List<FlSpot> vistHor,
    required List<Map<String, dynamic>> table,
    required String tipoPozo,
    dynamic Pvfci,
    dynamic Dhfci,
    dynamic Larca,
    dynamic Larcb,
    dynamic Ltan,
    dynamic Pvfst,
    dynamic Dhfst,
    dynamic Pdfci,
    dynamic Pdfst,
    dynamic Pdfcd,
    dynamic DH,
    dynamic angmax,
    List<dynamic>? Az,
    List<dynamic>? inc,
  }) {
    _summaryData = summary;
    _surveyLmdData = surveyLmd;
    _scatterData = scatter;
    _vistHorData = vistHor;
    _tableData = table;
    _tipoPozo = tipoPozo;
    _Pvfci = Pvfci;
    _Dhfci = Dhfci;
    _Larca = Larca;
    _Larcb = Larcb;
    _Ltan = Ltan;
    _Pvfst = Pvfst;
    _Dhfst = Dhfst;
    _Pdfci = Pdfci;
    _Pdfst = Pdfst;
    _Pdfcd = Pdfcd;
    _DH = DH;
    _angmax = angmax;
    _Az = Az ?? [];
    _inc = inc ?? [];
    notifyListeners();
  }

  void updateTipoPozo(String tipoPozo) {
    _tipoPozo = tipoPozo;
    notifyListeners();
  }
  

  void clearData() {
    _summaryData = {};
    _surveyLmdData = [];
    _scatterData = [];
    _vistHorData = [];
    _tableData = [];
    _tipoPozo = '';
    _Pvfci = null;
    _Dhfci = null;
    _Larca = null;
    _Larcb = null;
    _Ltan = null;
    _Pvfst = null;
    _Dhfst = null;
    _Pdfci = null;
    _Pdfst = null;
    _Pdfcd = null;
    _DH = null;
    _angmax = null;
    _Az = [];
    _inc = [];
    notifyListeners();
  }
}