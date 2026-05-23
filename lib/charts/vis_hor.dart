import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'dart:math' as math;

// class vist_Hor extends StatelessWidget {
//   final List<FlSpot> puntos;

//   const vist_Hor({super.key, required this.puntos});

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
//     int maxLabels = 3; // puedes ajustar (3–5 recomendado)
//     double rawInterval = rangeX / maxLabels;

//     double niceInterval(double raw) {
//       if (raw <= 0) return 1;
//       double magnitude = math.pow(10, (math.log(raw) / math.ln10).floorToDouble()).toDouble();
//       return (raw / magnitude).ceil() * magnitude;
//     }

//     double intervalX = niceInterval(rawInterval);
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
//             'Vista Horizontal',
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
//                           interval: intervalX,
//                           getTitlesWidget: (value, meta) {
//                           const double epsilon = 0.001;

//                           double cleanValue(double v) {
//                             if (v.abs() < 0.05) return 0; // evita -0
//                             return v;
//                           }

//                           double v = cleanValue(value);

//                           bool isMin = (value - minX).abs() < epsilon;
//                           bool isMax = (value - maxX).abs() < epsilon;

//                           // 🔥 Forzar min y max
//                           if (isMin || isMax) {
//                             return Text(
//                               v.toStringAsFixed(0),
//                               style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
//                             );
//                           }

//                           // 🔥 Solo múltiplos del intervalo
//                           if ((value / intervalX).roundToDouble() != (value / intervalX)) {
//                             return const SizedBox();
//                           }

//                           return Text(
//                             v.toStringAsFixed(0),
//                             style: const TextStyle(fontSize: 10),
//                           );
//                         },
//                         ),
//                         axisNameWidget: const Text('Desplazamiento al este (m)', style: TextStyle(fontSize: 12)),
//                       ),
//                       leftTitles: AxisTitles(
//                         sideTitles: SideTitles(
//                           showTitles: true,
//                           reservedSize: 40,
//                           getTitlesWidget: (value, meta) {
//                             const double epsilon = 0.001;

//                             double cleanValue(double v) {
//                               if (v.abs() < 0.05) return 0;
//                               return v;
//                             }

//                             double v = cleanValue(value);

//                             bool isMin = (value - minX).abs() < epsilon;
//                             bool isMax = (value - maxX).abs() < epsilon;

//                             // ✅ CAMBIO: ocultar bordes en lugar de forzarlos
//                             if (isMin || isMax) return const SizedBox();

//                             // Solo múltiplos del intervalo
//                             double remainder = (value / intervalX) - (value / intervalX).roundToDouble();
//                             if (remainder.abs() > 0.01) return const SizedBox();

//                             return Text(
//                               v.toStringAsFixed(0),
//                               style: const TextStyle(fontSize: 10),
//                             );
//                           },
//                         ),
//                         axisNameWidget: const Text('Desplazamiento al norte (m)', style: TextStyle(fontSize: 12)),
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
//                               '(${spot.x}, ${spot.y})',
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

class vist_Hor extends StatelessWidget {
  final List<FlSpot> puntos;

  const vist_Hor({super.key, required this.puntos});

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
    int maxLabels = 3;
    double rawInterval = rangeX / maxLabels;

    double niceInterval(double raw) {
      if (raw <= 0) return 1;
      double magnitude = math.pow(10, (math.log(raw) / math.ln10).floorToDouble()).toDouble();
      return (raw / magnitude).ceil() * magnitude;
    }

    double intervalX = niceInterval(rawInterval);
    double rangeY = (maxY - minY == 0) ? 1 : (maxY - minY);

    minX -= rangeX * 0.05;
    maxX += rangeX * 0.05;
    minY -= rangeY * 0.05;
    maxY += rangeY * 0.05;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Vista Horizontal',
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
                          interval: intervalX,
                          getTitlesWidget: (value, meta) {
                            const double epsilon = 0.001;

                            double cleanValue(double v) {
                              if (v.abs() < 0.05) return 0;
                              return v;
                            }

                            double v = cleanValue(value);

                            bool isMin = (value - minX).abs() < epsilon;
                            bool isMax = (value - maxX).abs() < epsilon;

                            // Ocultar etiquetas de los bordes
                            if (isMin || isMax) return const SizedBox();

                            // Solo múltiplos del intervalo
                            double remainder = (value / intervalX) - (value / intervalX).roundToDouble();
                            if (remainder.abs() > 0.01) return const SizedBox();

                            return Text(
                              v.toStringAsFixed(0),
                              style: const TextStyle(fontSize: 10),
                            );
                          },
                        ),
                        axisNameWidget: const Text(
                          'Desplazamiento al este (m)',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            // Ocultar solo los extremos del eje Y
                            if (value == minY || value == maxY) {
                              return Container();
                            }
                            return Text('${value.floor()}');
                          },
                        ),
                        axisNameWidget: const Text(
                          'Desplazamiento al norte (m)',
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
                              '(${spot.x}, ${spot.y})',
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