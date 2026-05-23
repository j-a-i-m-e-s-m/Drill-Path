//ort 'package:fitness_dashboard_ui/widgets/custom_card_widget.dart';
import 'package:trayectoria_gui/Widgets/custom_card_widget.dart';
import 'package:flutter/material.dart';

// class SummaryDetails extends StatelessWidget {
//   const SummaryDetails({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomCard(
//       color: const Color(0xFF2F353E),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           buildDetails('Inclinación Max', '35°'),
//           buildDetails('Azimuth', '105°'),
//           buildDetails('DLA Max', '3'),
//           buildDetails('MD', '4543''m'),
//         ],
//       ),
//     );
//   }

//   Widget buildDetails(String key, String value) {
//     return Column(
//       children: [
//         Text(
//           key,
//           style: const TextStyle(fontSize: 11, color: Colors.grey),
//         ),
//         const SizedBox(height: 2),
//         Text(
//           value,
//           style: const TextStyle(fontSize: 14),
//         ),
//       ],
//     );
//   }
// }
/////////////////////////////////// desde aqui empiezan las pruebas, el de arriba es el bueno 

class SummaryDetails extends StatelessWidget {
  final String inclinacionMax;
  final String azimuth;
  final String dlaMax;
  final String md;

  const SummaryDetails({
    super.key,
    required this.inclinacionMax,
    required this.azimuth,
    required this.dlaMax,
    required this.md,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      color: const Color(0xFF2F353E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildDetails('Inclinación Max', '$inclinacionMax°'), // Mostrar 
          buildDetails('Azimuth', '$azimuth°'),               // Mostrar 
          buildDetails('DLA Max', dlaMax),                    // Mostrar 
          buildDetails('md', '$md m'),                        // Mostrar 
        ],
      ),
    );
  }

  Widget buildDetails(String key, String value) {
    return Column(
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}