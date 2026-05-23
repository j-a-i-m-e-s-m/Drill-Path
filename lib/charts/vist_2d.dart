
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'dart:math' as math;



// class ScatterChartExample extends StatelessWidget {
//   final List<FlSpot> puntos;

//   const ScatterChartExample({super.key, required this.puntos});

//   @override
//   Widget build(BuildContext context) {
//     if (puntos.isEmpty) {
//       return const Center(
//         child: Text(
//           "No hay datos para mostrar",
//           style: TextStyle(color: Colors.white),
//         ),
//       );
//     }

//     double minX = puntos.map((e) => e.x).reduce((a, b) => a < b ? a : b);
//     double maxX = puntos.map((e) => e.x).reduce((a, b) => a > b ? a : b);
//     double minY = puntos.map((e) => e.y).reduce((a, b) => a < b ? a : b);
//     double maxY = puntos.map((e) => e.y).reduce((a, b) => a > b ? a : b);

//     double rangeX = (maxX - minX == 0) ? 1 : (maxX - minX);
//     double rangeY = (maxY - minY == 0) ? 1 : (maxY - minY);

//     minX -= rangeX * 0.05;
//     maxX += rangeX * 0.05;
//     minY -= rangeY * 0.05;
//     maxY += rangeY * 0.05;

//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Text(
//             'Proyección Vertical',
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: backgroundColor,
//               borderRadius: BorderRadius.circular(12),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 2,
//                   blurRadius: 5,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.9,
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 child: LineChart(
//                   LineChartData(
//                     backgroundColor: backgroundColor,
//                     gridData: FlGridData(
//                       show: true,
//                       getDrawingHorizontalLine: (value) {
//                         return const FlLine(
//                           color: Colors.grey,
//                           strokeWidth: 1,
//                           dashArray: [5, 5],
//                         );
//                       },
//                       getDrawingVerticalLine: (value) {
//                         return const FlLine(
//                           color: Colors.grey,
//                           strokeWidth: 1,
//                           dashArray: [5, 5],
//                         );
//                       },
//                     ),
//                     titlesData: FlTitlesData(
//                       show: true,
//                       bottomTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           reservedSize: 30,
//                           getTitlesWidget: (value, meta) {
//                             if (value == minX || value == maxX) {
//                               return Container();
//                             }
//                             return Text('${value.floor()}');
//                           },
//                         ),
//                         axisNameWidget: const Text('Sección Vertical (m)', style: TextStyle(fontSize: 12)),
//                       ),
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           reservedSize: 40,
//                           getTitlesWidget: (value, meta) {
//                             if (value == minY || value == maxY) {
//                               return Container();
//                             }
//                             return Text('${-value.floor()}');
//                           },
//                         ),
//                         axisNameWidget: const Text('Profundidad vertical (mv)', style: TextStyle(fontSize: 12)),
//                       ),
//                       topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     ),
//                     borderData: FlBorderData(
//                       show: true,
//                       border: Border.all(
//                         color: const Color.fromARGB(255, 252, 250, 250),
//                         width: 1,
//                       ),
//                     ),
//                     minX: minX,
//                     maxX: maxX,
//                     minY: minY,
//                     maxY: maxY,
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: puntos,
//                         isCurved: false,
//                         dotData: const FlDotData(show: true),
//                         color: LineColor,
//                         barWidth: 2,
//                       ),
//                     ],
//                     lineTouchData: LineTouchData(
//                       touchTooltipData: LineTouchTooltipData(
//                         getTooltipColor: (LineBarSpot touchedSpot) => const Color.fromARGB(255, 44, 72, 65),
//                         fitInsideHorizontally: true,
//                         fitInsideVertically: true,
//                         tooltipMargin: 10,
//                         getTooltipItems: (List<LineBarSpot> touchedSpots) {
//                           return touchedSpots.map((spot) {
//                             return LineTooltipItem(
//                               '(${spot.x}, ${spot.y.toStringAsFixed(2)})',
//                               const TextStyle(color: Colors.blue),
//                             );
//                           }).toList();
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class ScatterChartExample extends StatelessWidget {
  final List<FlSpot> puntos;

  const ScatterChartExample({super.key, required this.puntos});

  @override
  Widget build(BuildContext context) {
    if (puntos.isEmpty) {
      return const Center(
        child: Text(
          "No hay datos para mostrar",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    double minX = puntos.map((e) => e.x).reduce((a, b) => a < b ? a : b);
    double maxX = puntos.map((e) => e.x).reduce((a, b) => a > b ? a : b);
    double minY = puntos.map((e) => e.y).reduce((a, b) => a < b ? a : b);
    double maxY = puntos.map((e) => e.y).reduce((a, b) => a > b ? a : b);

    double rangeX = (maxX - minX == 0) ? 1 : (maxX - minX);
    double rangeY = (maxY - minY == 0) ? 1 : (maxY - minY);

    // ✅ AÑADIDO: lógica de intervalo "bonito" igual que DogLeg
    int maxLabels = 3;
    double rawInterval = rangeX / maxLabels;

    double niceInterval(double raw) {
      if (raw <= 0) return 1;
      double magnitude = math.pow(10, (math.log(raw) / math.ln10).floorToDouble()).toDouble();
      return (raw / magnitude).ceil() * magnitude;
    }

    double intervalX = niceInterval(rawInterval);

    // ✅ AÑADIDO: helper para evitar -0.0
    double cleanValue(double v) {
      if (v.abs() < 0.05) return 0;
      return v;
    }

    minX -= rangeX * 0.05;
    maxX += rangeX * 0.05;
    minY -= rangeY * 0.05;
    maxY += rangeY * 0.05;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Proyección Vertical',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.4,
                child: LineChart(
                  LineChartData(
                    backgroundColor: backgroundColor,
                    gridData: FlGridData(
                      show: true,
                      getDrawingHorizontalLine: (value) {
                        return const FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        );
                      },
                      getDrawingVerticalLine: (value) {
                        return const FlLine(
                          color: Colors.grey,
                          strokeWidth: 1,
                          dashArray: [5, 5],
                        );
                      },
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: intervalX, // ✅ AÑADIDO: controla cuántas líneas genera fl_chart
                          getTitlesWidget: (value, meta) {
                            const double epsilon = 0.001;

                            double v = cleanValue(value);

                            bool isMin = (value - minX).abs() < epsilon;
                            bool isMax = (value - maxX).abs() < epsilon;

                            // ✅ Ocultar etiquetas del borde (evita que se corten)
                            if (isMin || isMax) return const SizedBox();

                            // ✅ Solo mostrar múltiplos del intervalo
                            double remainder = (value / intervalX) - (value / intervalX).roundToDouble();
                            if (remainder.abs() > 0.01) return const SizedBox();

                            return Text(
                              v.toInt().toString(), // era v.toStringAsFixed(1)
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                        axisNameWidget: const Text(
                          'Sección Vertical (m)',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            if (value == minY || value == maxY) {
                              return Container();
                            }
                            return Text('${-value.floor()}');
                          },
                        ),
                        axisNameWidget: const Text(
                          'Profundidad vertical (mv)',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color.fromARGB(255, 252, 250, 250),
                        width: 1,
                      ),
                    ),
                    minX: minX,
                    maxX: maxX,
                    minY: minY,
                    maxY: maxY,
                    lineBarsData: [
                      LineChartBarData(
                        spots: puntos,
                        isCurved: false,
                        dotData: const FlDotData(show: true),
                        color: LineColor,
                        barWidth: 2,
                      ),
                    ],
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (LineBarSpot touchedSpot) =>
                            const Color.fromARGB(255, 44, 72, 65),
                        fitInsideHorizontally: true,
                        fitInsideVertically: true,
                        tooltipMargin: 10,
                        getTooltipItems: (List<LineBarSpot> touchedSpots) {
                          return touchedSpots.map((spot) {
                            return LineTooltipItem(
                              '(${spot.x}, ${spot.y.toStringAsFixed(2)})',
                              const TextStyle(color: Colors.blue),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}