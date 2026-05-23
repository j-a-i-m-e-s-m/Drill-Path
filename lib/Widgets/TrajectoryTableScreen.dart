// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:trayectoria_gui/util/trajectory_provider.dart'; // Asegúrate de importar
// import 'package:trayectoria_gui/const/const.dart'; // Para cardBackgroundColor
// import 'package:trayectoria_gui/Widgets/pie_chart_widget.dart';
// /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
// class TrajectoryTableScreen extends StatelessWidget {
//   const TrajectoryTableScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final scrollController = ScrollController();

//     return Consumer<TrajectoryProvider>(
//       builder: (context, provider, child) {
//         if (provider == null) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Parámetros de la trayectoria del pozo'),
//               backgroundColor: cardBackgroundColor,
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('Proveedor no disponible, reinicia la app.', style: TextStyle(color: Colors.white)),
//                   const SizedBox(height: 16.0),
//                 ],
//               ),
//             ),
//           );
//         }
//         if (provider.tableData == null || provider.tableData!.isEmpty) {
//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Parámetros de la trayectoria del pozo'),
//               backgroundColor: cardBackgroundColor,
//             ),
//             body: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text('No hay datos disponibles. Completa el formulario primero.', style: TextStyle(color: Colors.white)),
//                   const SizedBox(height: 16.0),
                  
//                 ],
//               ),
//             ),
//           );
//         }
//         return Scaffold(
//           appBar: AppBar(
//             title: const Text('Parámetros de la trayectoria del pozo'),
//             backgroundColor: cardBackgroundColor,
//           ),
//           body: Center(  // Add this to center the content
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,  // Change to center
//                   children: [
//                     Chart(),
//                     const SizedBox(height: 16.0),
//                     SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: Scrollbar(
//                         controller: scrollController,
//                         thumbVisibility: true,
//                         child: SingleChildScrollView(
//                           scrollDirection: Axis.horizontal,
//                           controller: scrollController,
//                           child: buildTrajectoryTable(provider.tipoPozo ?? 'j', provider.tableData ?? [], provider),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Función para construir la tabla combinando tipoPozo y tableData
//   Widget buildTrajectoryTable(String tipoPozo, List<Map<String, dynamic>> tableData, TrajectoryProvider provider) {
//     // print('SummaryData en TrajectoryTable: ${provider.summaryData}');
//     final Map<String, List<String>> outputs = {
//       'Tipo 1': [
//         'Azimuth',
//         'Inclinación',
//         'Desplazamiento horizontal al final de la curva de incremento (X2)',
//         'Desplazamiento horizontal al objetivo (X3)',
//         'Longitud de arco de incremento (LARC)',
//         'Longitud de la sección tangente (LTAN)', 
//         'Profundidad total desarrollada',
        
//       ],
//       'Tipo 2': [
//         'Azimuth',
//         'Inclinación',
//         'Desplazamiento horizontal al final de la curva de incremento (X2)',
//         'Desplazamiento horizontal al final de la seccion tangente (X3)',
//         'Desplazamiento horizontal al objetivo (X4)',
//         'Longitud de arco de incremento (LARC1)',
//         'Longitud de arco de decremento (LARC2)',
//         'Longitud de la sección tangente (LTAN)',
//         'Profundidad vertical al final de la curva de incremento (D2)',
//         'Profundidad vertical al final de la sección tangente (D3)',
//         'Profundidad desarrollada al final de la sección tangente',
//         'Profundidad desarrollada al final de la curva de incremento',
//         'Profundidad desarrollada al final de la curva de decremento',
//         'Profundidad total desarrollada',
        
//       ],
//       'Tipo 3': [
//         'Azimuth',
//         'Inclinación',
//         'Desplazamiento horizontal al final de la curva',
//         'Desplazamiento horizontal al objetivo (X2)',
//         'Longitud de arco de incremento (LARC)',
//         'Profundidad total desarrollada',
//       ],
//     };

//     String tableType;
//     switch (tipoPozo) {
//       case 'j':
//         tableType = 'Tipo 1';
//         break;
//       case 's':
//         tableType = 'Tipo 2';
//         break;
//       case 'h':
//         tableType = 'Tipo 3';
//         break;
//       default:
//         tableType = 'Tipo 1';
//     }

//     // Mapeo de salidas a claves de tableData y variables adicionales
//     const Map<String, String> mapping = {
//       'Azimuth': 'azimuth',
//       'Inclinación': 'inclinacionMax',
//       'Desplazamiento horizontal al final de la curva de incremento (X2)': 'Dhfci', // X2 maps to Dhfci
//       'Desplazamiento horizontal al objetivo (X3)': 'DH', // X3 maps to DH for Tipo 1
//       'Desplazamiento horizontal al final de la seccion tangente (X3)': 'Dhfst', // X3 maps to Dhfst for Tipo 2
//       'Desplazamiento horizontal al objetivo (X4)': 'DH', // X4 maps to DH for Tipo 2
//       'Desplazamiento horizontal al final de la curva': 'Dhfci', // For Tipo 3
//       'Desplazamiento horizontal al objetivo (X2)': 'DH', // X2 maps to DH for Tipo 3
//       'Longitud de arco de incremento (LARC)': 'Larca', // LARC maps to Larca for Tipo 1 and Tipo 3
//       'Longitud de arco de incremento (LARC1)': 'Larca', // LARC1 maps to Larca for Tipo 2
//       'Longitud de arco de decremento (LARC2)': 'Larcb', // LARC2 maps to Larcb
//       'Longitud de la sección tangente (LTAN)': 'Ltan', // LTAN maps to Ltan
//       'Profundidad vertical al final de la curva de incremento (D2)': 'Pvfci', // D2 maps to Pvfci
//       'Profundidad vertical al final de la sección tangente (D3)': 'Pvfst', // D3 maps to Pvfst
//       'Profundidad desarrollada al final de la sección tangente': 'Pdfst',
//       'Profundidad desarrollada al final de la curva de incremento': 'Pdfci',
//       'Profundidad desarrollada al final de la curva de decremento': 'Pdfcd',
//       'Profundidad total desarrollada': 'md',
      
//     };

//     // Usar outputs como etiquetas y buscar valores en tableData
//     return DataTable(
//     columnSpacing: 100,
//     headingRowColor: MaterialStateProperty.all(Colors.grey[900]),
//     columns: const [
//       DataColumn(label: Text('Salida', style: TextStyle(color: Colors.white))),
//       DataColumn(label: Text('Valor', style: TextStyle(color: Colors.white))),
//     ],
//     rows: outputs[tableType]!.map((salida) {
//       final clave = mapping[salida] ?? '0.0';
//       final valor = (provider.summaryData.containsKey(clave))
//           ? provider.summaryData[clave]?.toString() ?? '0.0'
//           : (tableData.isNotEmpty && tableData[0].containsKey(clave))
//               ? tableData[0][clave]?.toString() ?? '0.0'
//               : (clave == 'Pvfci' ? provider.Pvfci?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Dhfci' ? provider.Dhfci?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Larca' ? provider.Larca?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Larcb' ? provider.Larcb?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Ltan' ? provider.Ltan?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Pvfst' ? provider.Pvfst?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Dhfst' ? provider.Dhfst?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Pdfci' ? provider.Pdfci?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Pdfst' ? provider.Pdfst?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'Pdfcd' ? provider.Pdfcd?.toDouble().toStringAsFixed(2) ?? '0.00 m' :
//                 clave == 'DH' ? provider.DH?.toDouble().toStringAsFixed(2) ?? '0.00 °' :
//                 clave == 'angmax' ? provider.angmax?.toDouble().toStringAsFixed(2) ?? '0.00 °' :
//                 '0.0');
//       return DataRow(cells: [
//         DataCell(SelectableText(salida)),
//         DataCell(SelectableText(valor)),
//       ]);
//     }).toList(),
//   );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart'; // Asegúrate de importar
import 'package:trayectoria_gui/const/const.dart'; // Para cardBackgroundColor
import 'package:trayectoria_gui/Widgets/pie_chart_widget.dart';
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
class TrajectoryTableScreen extends StatelessWidget {
  const TrajectoryTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Consumer<TrajectoryProvider>(
      builder: (context, provider, child) {
        if (provider == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Parámetros de la trayectoria del pozo'),
              backgroundColor: cardBackgroundColor,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Proveedor no disponible, reinicia la app.', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          );
        }
        if (provider.tableData == null || provider.tableData!.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Parámetros de la trayectoria del pozo'),
              backgroundColor: cardBackgroundColor,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No hay datos disponibles. Completa el formulario primero.', style: TextStyle(color: Colors.white)),
                  const SizedBox(height: 16.0),
                  
                ],
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Parámetros de la trayectoria del pozo'),
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),///mueve el color del banner de arriba
            foregroundColor:Color.fromARGB(255, 36, 35, 35),
          ),
          
          body:
           Center(  // Add this to center the content
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,  // Change to center
                  children: [
                    Chart(),
                    const SizedBox(height: 16.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Scrollbar(
                        controller: scrollController,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: scrollController,
                          child: buildTrajectoryTable(provider.tipoPozo ?? 'j', provider.tableData ?? [], provider),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Función para construir la tabla combinando tipoPozo y tableData
  Widget buildTrajectoryTable(String tipoPozo, List<Map<String, dynamic>> tableData, TrajectoryProvider provider) {
    // print('SummaryData en TrajectoryTable: ${provider.summaryData}');
    final Map<String, List<String>> outputs = {
      'Tipo 1': [
        'Azimuth (°)',
        'Inclinación (°)',
        'Desplazamiento horizontal al final de la curva de incremento (X2)',
        'Desplazamiento horizontal al objetivo (X3)',
        'Longitud de arco de incremento (LARC)',
        'Longitud de la sección tangente (LTAN)', 
        'Profundidad total desarrollada',
        
      ],
      'Tipo 2': [
        'Azimuth (°)',
        'Inclinación (°)',
        'Desplazamiento horizontal al final de la curva de incremento (X2)',
        'Desplazamiento horizontal al final de la seccion tangente (X3)',
        'Desplazamiento horizontal al objetivo (X4)',
        'Longitud de arco de incremento (LARC1)',
        'Longitud de arco de decremento (LARC2)',
        'Longitud de la sección tangente (LTAN)',
        'Profundidad vertical al final de la curva de incremento (D2)',
        'Profundidad vertical al final de la sección tangente (D3)',
        'Profundidad desarrollada al final de la sección tangente',
        'Profundidad desarrollada al final de la curva de incremento',
        'Profundidad desarrollada al final de la curva de decremento',
        'Profundidad total desarrollada',
        
      ],
      'Tipo 3': [
        'Azimuth (°)',
        'Inclinación (°)',
        'Desplazamiento horizontal al final de la curva',
        'Desplazamiento horizontal al objetivo (X2)',
        'Longitud de arco de incremento (LARC)',
        'Profundidad total desarrollada',
      ],
    };

    String tableType;
    switch (tipoPozo) {
      case 'j':
        tableType = 'Tipo 1';
        break;
      case 's':
        tableType = 'Tipo 2';
        break;
      case 'h':
        tableType = 'Tipo 3';
        break;
      default:
        tableType = 'Tipo 1';
    }

    // Mapeo de salidas a claves de tableData y variables adicionales
    const Map<String, String> mapping = {
      'Azimuth (°)': 'azimuth',
      'Inclinación (°)': 'inclinacionMax',
      'Desplazamiento horizontal al final de la curva de incremento (X2)': 'Dhfci', // X2 maps to Dhfci
      'Desplazamiento horizontal al objetivo (X3)': 'DH', // X3 maps to DH for Tipo 1
      'Desplazamiento horizontal al final de la seccion tangente (X3)': 'Dhfst', // X3 maps to Dhfst for Tipo 2
      'Desplazamiento horizontal al objetivo (X4)': 'DH', // X4 maps to DH for Tipo 2
      'Desplazamiento horizontal al final de la curva': 'Dhfci', // For Tipo 3
      'Desplazamiento horizontal al objetivo (X2)': 'DH', // X2 maps to DH for Tipo 3
      'Longitud de arco de incremento (LARC)': 'Larca', // LARC maps to Larca for Tipo 1 and Tipo 3
      'Longitud de arco de incremento (LARC1)': 'Larca', // LARC1 maps to Larca for Tipo 2
      'Longitud de arco de decremento (LARC2)': 'Larcb', // LARC2 maps to Larcb
      'Longitud de la sección tangente (LTAN)': 'Ltan', // LTAN maps to Ltan
      'Profundidad vertical al final de la curva de incremento (D2)': 'Pvfci', // D2 maps to Pvfci
      'Profundidad vertical al final de la sección tangente (D3)': 'Pvfst', // D3 maps to Pvfst
      'Profundidad desarrollada al final de la sección tangente': 'Pdfst',
      'Profundidad desarrollada al final de la curva de incremento': 'Pdfci',
      'Profundidad desarrollada al final de la curva de decremento': 'Pdfcd',
      'Profundidad total desarrollada': 'md',
      
    };
        // Mapeo de claves a sufijos para los valores
    const Map<String, String> suffixes = {
      'azimuth': ' °',
      'inclinacionMax': ' °',
      'Dhfci': ' m',
      'Dhfst': ' m',
      'DH': ' m',
      'Larca': ' m',
      'Larcb': ' m',
      'Ltan': ' m',
      'Pvfci': ' m',
      'Pvfst': ' m',
      'Pdfci': ' m',
      'Pdfst': ' m',
      'Pdfcd': ' m',
      'md': ' m',
    };

    // Usar outputs como etiquetas y buscar valores en tableData
    return DataTable(
    columnSpacing: 100,
    headingRowColor: MaterialStateProperty.all(const Color.fromARGB(255, 255, 255, 255)),
    columns: const [
      DataColumn(label: Text('Parámetro', style: TextStyle(color: Color.fromARGB(255, 36, 35, 35)))),
      DataColumn(label: Text('Valor', style: TextStyle(color: Color.fromARGB(255, 36, 35, 35)))),
    ],
    rows: outputs[tableType]!.map((salida) {
      final clave = mapping[salida] ?? '0.0';
      final suffix = suffixes[clave] ?? ''; // Usa el sufijo correspondiente o vacío si no hay
      final valor = (provider.summaryData.containsKey(clave))
          ? (provider.summaryData[clave] is num
            ? '${(provider.summaryData[clave] as num).toDouble().toStringAsFixed(2)}$suffix'
            : provider.summaryData[clave]?.toString() ?? '0.00$suffix')
          : (tableData.isNotEmpty && tableData[0].containsKey(clave))
              ? (tableData[0][clave] is num
                  ? '${(tableData[0][clave] as num).toDouble().toStringAsFixed(2)}$suffix'
                  : tableData[0][clave]?.toString() ?? '0.00$suffix')

              : (clave == 'Pvfci' ? (provider.Pvfci?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'Dhfci' ? (provider.Dhfci?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'Larca' ? (provider.Larca?.toDouble().toStringAsFixed(2) ?? '0.00'  ) + suffix :
                clave == 'Larcb' ? (provider.Larcb?.toDouble().toStringAsFixed(2) ?? '0.00 '  ) + suffix :
                clave == 'Ltan' ? (provider.Ltan?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'Pvfst' ? (provider.Pvfst?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'Dhfst' ? (provider.Dhfst?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'Pdfci' ? (provider.Pdfci?.toDouble().toStringAsFixed(2) ?? '0.00'  ) + suffix :
                clave == 'Pdfst' ? (provider.Pdfst?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'Pdfcd' ? (provider.Pdfcd?.toDouble().toStringAsFixed(2) ?? '0.00' ) + suffix :
                clave == 'DH' ? (provider.DH?.toDouble().toStringAsFixed(2) ?? '0.00'  ) + suffix :
                clave == 'md' ? (provider.DH?.toDouble().toStringAsFixed(2) ?? '0.00'  ) + suffix :
                clave == 'inclinacionMax' ? (provider.DH?.toDouble().toStringAsFixed(2) ?? '0.00'  ) + suffix :
                clave == 'azimuth' ? (provider.DH?.toDouble().toStringAsFixed(2) ?? '0.00'  ) + suffix :
                clave == 'angmax' ? (provider.angmax?.toDouble().toStringAsFixed(2) ?? '0.00' ) + ' °' :
                '0.00$suffix');
      return DataRow(
        ///color: MaterialStateProperty.all(Colors.white),
        cells: [
        DataCell(SelectableText(salida)),
        DataCell(SelectableText(valor)),
      ]);
    }).toList(),
  );
  }
}
