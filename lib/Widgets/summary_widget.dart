import 'package:trayectoria_gui/const/const.dart';
import 'package:trayectoria_gui/Widgets/pie_chart_widget.dart';
import 'package:trayectoria_gui/Widgets/scheduled_widget.dart';
import 'package:trayectoria_gui/Widgets/summary_details.dart';
import 'package:flutter/material.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart';
import 'package:provider/provider.dart';

// class SummaryWidget extends StatelessWidget {
//   const SummaryWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: cardBackgroundColor,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const Chart(), // Aquí está la imagen del pozo 
//             Consumer<TrajectoryProvider>(
//               builder: (context, provider, child) {
//                 return SummaryDetails(
//                   inclinacionMax: provider.summaryData['inclinacionMax'] ?? '0',
//                   azimuth: provider.summaryData['azimuth'] ?? '0',
//                   dlaMax: provider.summaryData['dlaMax'] ?? '0',
//                   md: provider.summaryData['md'] ?? '0',
//                 );
//               },
//             ),
//             const SizedBox(height: 40),
//             const Expanded(
//               child: Scheduled(), // Scheduled sin callbacks
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//////////////////////////el de arriba es el bueno/
class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        //color: cardBackgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // const SizedBox(height: 10),
            const Expanded(
              child: Scheduled(), // Scheduled sin callbacks
            ),
          ],
        ),
      ),
    );
  }
}
//////////////////contenedor del formulario