import 'package:flutter/material.dart';
import 'package:trayectoria_gui/charts/vist_2d.dart';
import 'package:trayectoria_gui/charts/dg_lg.dart';
import 'package:trayectoria_gui/charts/vis_hor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:trayectoria_gui/Widgets/header_widget.dart';
import 'package:trayectoria_gui/util/responsive.dart';
import 'package:trayectoria_gui/Widgets/side_menu_widget.dart';
import 'package:trayectoria_gui/Widgets/summary_widget.dart';

class DashboardWidget_2 extends StatelessWidget {
  final List<FlSpot> puntosSurveyLmd;
  final List<FlSpot> puntosScatter;
  final List<FlSpot> puntosVistHor;

  const DashboardWidget_2({
    super.key,
    required this.puntosSurveyLmd,
    required this.puntosScatter,
    required this.puntosVistHor,
  });

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: backgroundColor, // Color de fondo para todo el dashboard
        child: Column(
          children: [
            // Agregar el HeaderWidget en la parte superior
            HeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: screenHeight,
                          color: backgroundColor,
                          child: Center(
                            child: ScatterChartExample(puntos: puntosScatter),
                          ),
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: screenHeight,
                          color: backgroundColor,
                          padding: const EdgeInsets.all(8),
                          child: Flex(
                            direction: Axis.vertical,
                            children: [
                              Flexible(
                                flex: 3,
                                child: DogLeg(puntos: puntosSurveyLmd),
                              ),
                              const SizedBox(height: 8),
                              Flexible(
                                flex: 3,
                                child: vist_Hor(puntos: puntosVistHor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Asegurar que el Scaffold tenga un Drawer (puedes personalizarlo)
      drawer: SideMenuWidget(),
      endDrawer: !Responsive.isDesktop(context)
          ? SummaryWidget()
          : null, // No se muestra en desktop o tablet si no es necesario
    );
  }
}
