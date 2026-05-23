import 'package:trayectoria_gui/Widgets/summary_widget.dart';
import 'package:trayectoria_gui/charts/Dashboard.dart';
import 'package:flutter/material.dart';
import 'package:trayectoria_gui/Widgets/side_menu_widget.dart';
import 'package:trayectoria_gui/util/responsive.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart';
import 'package:provider/provider.dart';
import 'package:trayectoria_gui/screens/graficos.dart';


class ChartsScreen extends StatelessWidget {
  const ChartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Gráficas de Trayectoria'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),///mueve el color del banner de arriba
        foregroundColor:Color.fromARGB(255, 36, 35, 35),
      ),
      body: Consumer<TrajectoryProvider>(
        builder: (context, provider, child) {
          // Verifica si hay datos disponibles
          if (provider.surveyLmdData.isEmpty &&
              provider.scatterData.isEmpty &&
              provider.vistHorData.isEmpty) {
            return const Center(
              child: Text(
                'No hay datos de gráficas disponibles',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          return DashboardWidget_3(
            puntosSurveyLmd: provider.surveyLmdData,
            puntosScatter: provider.scatterData,
            puntosVistHor: provider.vistHorData,
          );
        },
      ),
    );
  }
}