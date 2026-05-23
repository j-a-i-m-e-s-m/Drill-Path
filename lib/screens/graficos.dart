// import 'package:flutter/material.dart';
// import 'package:trayectoria_gui/charts/vist_2d.dart';
// import 'package:trayectoria_gui/charts/dg_lg.dart';
// import 'package:trayectoria_gui/charts/vis_hor.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:trayectoria_gui/const/const.dart';

// class DashboardWidget_3 extends StatelessWidget {
//   final List<FlSpot> puntosSurveyLmd;
//   final List<FlSpot> puntosScatter;
//   final List<FlSpot> puntosVistHor;

//   const DashboardWidget_3({
//     super.key,
//     required this.puntosSurveyLmd,
//     required this.puntosScatter,
//     required this.puntosVistHor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Container(
//         color: backgroundColor, // Color de fondo para todo el dashboard
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           height: screenHeight*.90,
//                           color: backgroundColor,
//                           padding: const EdgeInsets.all(8),
//                           child: Center(
//                             child: ScatterChartExample(puntos: puntosScatter),
//                           ),
//                         ),
//                       ),
                      
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           height: screenHeight*.90,
//                           color: backgroundColor,
//                           padding: const EdgeInsets.all(8),
//                           child: Center(
//                             child: DogLeg(puntos: puntosSurveyLmd),
//                               ),
//                         ),
//                       ),
                      
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           height:screenHeight*.90,
//                           color:backgroundColor,
//                           padding: const EdgeInsets.all(8),
//                           child: Center(
//                             child: vist_Hor(puntos: puntosVistHor),
//                             ),
//                           ),
//                         )
                              
//                      ],
//                    ),
//                  ),
//               ),
//             ),
//           ],
//          ),
//         ),
        
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:trayectoria_gui/charts/vist_2d.dart';
import 'package:trayectoria_gui/charts/dg_lg.dart';
import 'package:trayectoria_gui/charts/vis_hor.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:trayectoria_gui/util/responsive.dart';

class DashboardWidget_3 extends StatelessWidget {
  final List<FlSpot> puntosSurveyLmd;
  final List<FlSpot> puntosScatter;
  final List<FlSpot> puntosVistHor;

  const DashboardWidget_3({
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
        color: backgroundColor,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: !Responsive.isMobile(context)
                      ? // 📌 Versión ESCRITORIO (3 columnas)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: screenHeight * .90,
                                color: backgroundColor,
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child:
                                      ScatterChartExample(puntos: puntosScatter),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: screenHeight * .90,
                                color: backgroundColor,
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: DogLeg(puntos: puntosSurveyLmd),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: screenHeight * .90,
                                color: backgroundColor,
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: vist_Hor(puntos: puntosVistHor),
                                ),
                              ),
                            ),
                          ],
                        )
                      : // 📌 Versión MÓVIL/TABLET (2 columnas → scatter izquierda, dogleg+vistHor derecha)
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // const SizedBox(width: 18),
                            const SizedBox(height: 8),
                            Expanded(
                              flex: 3,
                              child: Container(
                                height: screenHeight,
                                color: backgroundColor,
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child:
                                      ScatterChartExample(puntos: puntosScatter),
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
                                child: Column(
                                  children: [
                                    Expanded(child: DogLeg(puntos: puntosSurveyLmd)),
                                    const SizedBox(height: 8),
                                    Expanded(child: vist_Hor(puntos: puntosVistHor)),
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
    );
  }
}