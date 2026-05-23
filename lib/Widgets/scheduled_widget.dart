import 'package:trayectoria_gui/const/const.dart';
import 'package:trayectoria_gui/data/schedule_task_data.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:trayectoria_gui/screens/pant_graficos.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart';
import 'package:provider/provider.dart';
import 'package:trayectoria_gui/data/calc_tray.dart';
import 'package:trayectoria_gui/model/schedule_model.dart';


// class Scheduled extends StatefulWidget {
//   const Scheduled({super.key});

//   @override
//   State<Scheduled> createState() => _ScheduledState();
// }

// class _ScheduledState extends State<Scheduled> {
//   final data = ScheduleTasksData();
//   late List<ScheduledModel> currentFields;
//   late List<TextEditingController> controllers;
//   String selectedOption = 'j';
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     currentFields = data.getScheduled(selectedOption); // Lista vacía al inicio
//     controllers = List.generate(
//       currentFields.length,
//       (index) => TextEditingController(),
//     );
//   }

//   void _updateFields() {
//     setState(() {
//       currentFields = data.getScheduled(selectedOption);
//       controllers = List.generate(
//         currentFields.length,
//         (index) => TextEditingController(),
//       );
//     });
//     // Actualizar tipoPozo en el provider
//     Provider.of<TrajectoryProvider>(context, listen: false).updateTipoPozo(selectedOption);
//   }

//   Future<void> _processData() async {
//     if (selectedOption.isEmpty) {
//       _showDialog("Error", "Por favor, seleccione un tipo de pozo.");
//       return;
//     }

//     if (controllers.any((controller) => controller.text.isEmpty)) {
//       _showDialog("Error", "Todos los campos deben estar llenos.");
//       return;
//     }

//     setState(() => isLoading = true);

//     try {
//       final service = WellTrajectoryService();

//       final tipoPozo = selectedOption;
//       final Map<String, double> inputs = {};
//       for (int i = 0; i < currentFields.length; i++) {
//         inputs[currentFields[i].date] = double.parse(controllers[i].text);
//       }

//       final coordenadasNsTarget = inputs['N/S al objetivo'] ?? 0.0;
//       final coordenadasNsSuperficie = inputs['N/S al conductor'] ?? 0.0;
//       final coordenadasEwTarget = inputs['E/W al objetivo'] ?? 0.0;
//       final coordenadasEwSuperficie = inputs['E/W en al conductor'] ?? 0.0;
//       final ritmoIncremento = inputs['BUR'] ?? 0.0;
//       final ritmoReduccion = inputs['DOR'] ?? 0.0;
//       final inicioDesviacion = inputs['KOP'] ?? 0.0;
//       final profundidadObjetivo = inputs['TVD-P.V.M.V.'] ?? 0.0;
//       final distanciaPostCurva = inputs['Extra'] ?? 0.0;

//       final resultado = service.calculateWellTrajectory(
//         tipoPozo: tipoPozo,
//         Nt: coordenadasNsTarget,
//         Ns: coordenadasNsSuperficie,
//         Et: coordenadasEwTarget,
//         Es: coordenadasEwSuperficie,
//         BUR: ritmoIncremento,
//         DOR: ritmoReduccion,
//         KOP: inicioDesviacion,
//         TVD: profundidadObjetivo,
//         ProfExt: distanciaPostCurva,
//       );

//       setState(() => isLoading = false);

//       if (resultado["status"] == "success") {
//         final data = resultado["data"] ?? {};
//         if (data["Pdes"] != null && data["Angm"] != null && data["At"] != null) {
//           final summary = {
//             "inclinacionMax": data['Angm'].toStringAsFixed(2),
//             "azimuth": data['At'].toString(),
//             "dlaMax": data['Dlamax'].toString(),
//             "md": data['Pdes'].toString(),
//           };

//           final survey = (data['survey'] as List).map((x) => x.toDouble()).toList();
//           final lmd = (data['lmd'] as List).map((x) => x.toDouble()).toList();
//           final surveyLmd = survey.asMap().entries.map((entry) {
//             return FlSpot(survey[entry.key], -lmd[entry.key]);
//           }).toList();

//           final vs = (data['vs'] as List).map((x) => x.toDouble()).toList();
//           final tvd = (data['tvd'] as List).map((y) => y.toDouble()).toList();
//           final scatter = vs.asMap().entries.map((entry) {
//             return FlSpot(vs[entry.key], -tvd[entry.key]);
//           }).toList();

//           final eof = (data['Eof'] as List).map((x) => x.toDouble()).toList();
//           final nof = (data['Nof'] as List).map((x) => x.toDouble()).toList();
//           final vistHor = eof.asMap().entries.map((entry) {
//             return FlSpot(eof[entry.key], nof[entry.key]);
//           }).toList();

//           final tableData = (data['data'] as List).map((e) => e as Map<String, dynamic>).toList();

//           final azimuth = (data['Az'] as List?)?.map((x) => x).toList() ?? [];
//           final inclinacion = (data['inc'] as List?)?.map((x) => x).toList() ?? [];

//           Provider.of<TrajectoryProvider>(context, listen: false).updateTrajectoryData(
//             summary: summary,
//             surveyLmd: surveyLmd,
//             scatter: scatter,
//             vistHor: vistHor,
//             table: tableData,
//             tipoPozo: selectedOption,
//             Pvfci: data["Pvfci"],
//             Dhfci: data["Dhfci"],
//             Larca: data["Larca"],
//             Larcb: data["Larcb"],
//             Ltan: data["Ltan"],
//             Pvfst: data["Pvfst"],
//             Dhfst: data["Dhfst"],
//             Pdfci: data["Pdfci"],
//             Pdfst: data["Pdfst"],
//             Pdfcd: data["Pdfcd"],
//             DH: data["DH"],
//             angmax: data["Angm"],
//             Az: azimuth,
//             inc: inclinacion,
//           );

//           Navigator.pushNamed(context, '/');
//         } else {
//           _showDialog("Error", "Los valores calculados son nulos.");
//         }
//       } else {
//         _showDialog("Error", resultado["message"] ?? "Error desconocido en el cálculo.");
//       }
//     } catch (e) {
//       setState(() => isLoading = false);
//       _showDialog("Error", "No se pudo procesar la trayectoria: $e");
//     }
//   }

//   void _showDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   // title: const Text('Introducir valores:'),
//       //   backgroundColor: const Color.fromARGB(255, 251, 9, 223),
//       // ),
//       backgroundColor: const Color.fromARGB(255, 205, 245, 62),
//       //backgroundColor: cardBackgroundColor,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
            
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: RadioListTile<String>(
//                     title: const Text('J', style: TextStyle(color: Colors.white)),
//                     value: 'j',
//                     groupValue: selectedOption,
//                     onChanged: (String? value) {
//                       setState(() {
//                         selectedOption = value!;
//                         _updateFields();
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: RadioListTile<String>(
//                     title: const Text('S', style: TextStyle(color: Colors.white)),
//                     value: 's',
//                     groupValue: selectedOption,
//                     onChanged: (String? value) {
//                       setState(() {
//                         selectedOption = value!;
//                         _updateFields();
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: RadioListTile<String>(
//                     title: const Text('H', style: TextStyle(color: Colors.white)),
//                     value: 'h',
//                     groupValue: selectedOption,
//                     onChanged: (String? value) {
//                       setState(() {
//                         selectedOption = value!;
//                         _updateFields();
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
            
//               for (var index = 0; index < currentFields.length; index++)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: Card(
//                     color: cardBackgroundColor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(12.0),
//                       child: TextFormField(
//                         controller: controllers[index],
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xFF15131C),
//                           hintText: currentFields[index].date,
//                           labelText: currentFields[index].title,
//                           labelStyle: const TextStyle(color: Colors.white),
//                           hintStyle: const TextStyle(color: Colors.grey),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         style: const TextStyle(color: Colors.white),
//                         keyboardType: TextInputType.number,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Este campo no puede estar vacío';
//                           }
//                           if (double.tryParse(value) == null) {
//                             return 'Por favor, ingrese un número válido';
//                           }
//                           return null;
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                         onPressed: isLoading
//                             ? null
//                             : () async {
//                                 setState(() {
//                                   isLoading = true; // empieza loading
//                                 });

//                                 // Ejecuta tu función (asegúrate que _processData sea async si hace cálculos largos)
//                                 await _processData();

//                                 setState(() {
//                                   isLoading = false; // termina loading
//                                 });

//                                 // Navega a la otra pantalla
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => (ChartsScreen()

//                                     ),
//                                   ),
//                                 );
//                               },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.blue,
//                           foregroundColor: Colors.white,
//                           minimumSize: const Size(200, 60),
//                         ),
//                         child: isLoading
//                             ? const CircularProgressIndicator()
//                             : const Text("Calcular Trayectoria"),
//                       )
//               ),
//             ////////
//           ],
//         ),
//       ),
//     );
//   }
// }

//////////////////////////////////////////////////el de arriba es el bueno


// class Scheduled extends StatefulWidget {
//   const Scheduled({super.key});

//   @override
//   State<Scheduled> createState() => _ScheduledState();
// }

// class _ScheduledState extends State<Scheduled> {
//   final data = ScheduleTasksData();
//   late List<ScheduledModel> currentFields;
//   late List<TextEditingController> controllers;
//   String selectedOption = '';
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     currentFields = data.getScheduled(selectedOption);
//     controllers = List.generate(
//       currentFields.length,
//       (index) => TextEditingController(),
//     );
//   }

//   void _updateFields() {
//     setState(() {
//       currentFields = data.getScheduled(selectedOption);
//       controllers = List.generate(
//         currentFields.length,
//         (index) => TextEditingController(),
//       );
//     });
//     Provider.of<TrajectoryProvider>(context, listen: false).updateTipoPozo(selectedOption);
//   }

//   Future<bool> _processData() async {
//     if (selectedOption.isEmpty) {
//       _showDialog("Error", "Por favor, seleccione un tipo de pozo.");
//       return false;
//     }

//     if (controllers.any((controller) => controller.text.isEmpty)) {
//       _showDialog("Error", "Todos los campos deben estar llenos.");
//       return false;
//     }

//     setState(() => isLoading = true);

//     try {
//       final service = WellTrajectoryService();
//       final tipoPozo = selectedOption;
//       final Map<String, double> inputs = {};
//       for (int i = 0; i < currentFields.length; i++) {
//         inputs[currentFields[i].date] = double.parse(controllers[i].text);
//       }

//       final resultado = service.calculateWellTrajectory(
//         tipoPozo: tipoPozo,
//         Nt: inputs['N/S al objetivo'] ?? 0.0,
//         Ns: inputs['N/S al conductor'] ?? 0.0,
//         Et: inputs['E/W al objetivo'] ?? 0.0,
//         Es: inputs['E/W en al conductor'] ?? 0.0,
//         BUR: inputs['BUR'] ?? 0.0,
//         DOR: inputs['DOR'] ?? 0.0,
//         KOP: inputs['KOP'] ?? 0.0,
//         TVD: inputs['TVD-P.V.M.V.'] ?? 0.0,
//         ProfExt: inputs['Extra'] ?? 0.0,
//       );

//       setState(() => isLoading = false);

//       if (resultado["status"] == "success") {
//         final data = resultado["data"] ?? {};
//         if (data["Pdes"] != null && data["Angm"] != null && data["At"] != null) {
//           Provider.of<TrajectoryProvider>(context, listen: false).updateTrajectoryData(
//             summary: {
//               "inclinacionMax": data['Angm'].toStringAsFixed(2),
//               "azimuth": data['At'].toString(),
//               "dlaMax": data['Dlamax'].toString(),
//               "md": data['Pdes'].toString(),
//             },
//             surveyLmd: (data['survey'] as List).asMap().entries.map((entry) => FlSpot((data['survey'] as List)[entry.key].toDouble(), -(data['lmd'] as List)[entry.key].toDouble())).toList(),
//             scatter: (data['vs'] as List).asMap().entries.map((entry) => FlSpot((data['vs'] as List)[entry.key].toDouble(), -(data['tvd'] as List)[entry.key].toDouble())).toList(),
//             vistHor: (data['Eof'] as List).asMap().entries.map((entry) => FlSpot((data['Eof'] as List)[entry.key].toDouble(), (data['Nof'] as List)[entry.key].toDouble())).toList(),
//             table: (data['data'] as List).map((e) => e as Map<String, dynamic>).toList(),
//             tipoPozo: selectedOption,
//             Pvfci: data["Pvfci"],
//             Dhfci: data["Dhfci"],
//             Larca: data["Larca"],
//             Larcb: data["Larcb"],
//             Ltan: data["Ltan"],
//             Pvfst: data["Pvfst"],
//             Dhfst: data["Dhfst"],
//             Pdfci: data["Pdfci"],
//             Pdfst: data["Pdfst"],
//             Pdfcd: data["Pdfcd"],
//             DH: data["DH"],
//             angmax: data["Angm"],
//             Az: (data['Az'] as List?)?.map((x) => x).toList() ?? [],
//             inc: (data['inc'] as List?)?.map((x) => x).toList() ?? [],
//           );
//           return true;
//         } else {
//           _showDialog("Error", "Los valores calculados son nulos.");
//           return false;
//         }
//       } else {
//         _showDialog("Error", resultado["message"] ?? "Error desconocido en el cálculo.");
//         return false;
//       }
//     } catch (e) {
//       setState(() => isLoading = false);
//       _showDialog("Error", "No se pudo procesar la trayectoria: $e");
//       return false;
//     }
//   }

//   void _showDialog(String title, String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 255, 255, 255),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(1.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 0.0),
//               child: Text(
//                 'Selecciona el tipo de pozo:',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
//               decoration: BoxDecoration(
//                 color: backgroundColor,
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: azul_tanis, width: 1.5),
//               ),
//               child: Row(
//                 children: [
//                   for (final option in [
//                     {'value': 'j', 'label': 'Pozo J'},
//                     {'value': 's', 'label': 'Pozo S'},
//                     {'value': 'h', 'label': 'Pozo H'},
//                   ])
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4),
//                         child: GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedOption = option['value']!;
//                               _updateFields();
//                             });
//                           },
//                           child: Container(
//                             height: 48,
//                             decoration: BoxDecoration(
//                               color: selectedOption == option['value']
//                                   ? azul_tanis
//                                   : Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                               border: Border.all(color: azul_tanis, width: 1.5),
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               option['label']!,
//                               style: TextStyle(
//                                 color: selectedOption == option['value']
//                                     ? Colors.white
//                                     : Colors.black,
//                                 fontWeight: FontWeight.w700,
//                                 fontSize: 14,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             // ✅ Bloque único y correcto
//             if (selectedOption.isNotEmpty) ...[
//               Padding(
//                 padding: const EdgeInsets.only(left: 0.0),
//                 child: Text(
//                   'Ingresa tus datos:',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               for (var index = 0; index < currentFields.length; index++)
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 5),
//                   child: SizedBox(
//                     height: 60,
//                     child: TextFormField(
//                       controller: controllers[index],
//                       decoration: InputDecoration(
//                         hintText: currentFields[index].date,
//                         labelText: currentFields[index].title,
//                         labelStyle: const TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
//                         hintStyle: const TextStyle(color: Colors.grey),///color: Colors.grey
//                         isDense: true,
//                         prefixIcon: Icon(currentFields[index].icon, color: azul_tanis),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: azul_tanis, width: 1.5),
//                         ),
//                         focusedBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: BorderSide(color: azul_tanis, width: 1.5),
//                         ),
//                       ),
//                       style: const TextStyle(color: Colors.grey),
//                       keyboardType: TextInputType.number,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Este campo no puede estar vacío';
//                         }
//                         if (double.tryParse(value) == null) {
//                           return 'Por favor, ingrese un número válido';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 20),
//             ], // ✅ fin del if — no hay nada más después de aquí
//           ],
//         ),
//       ),

//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: ElevatedButton(
//           onPressed: isLoading
//               ? null
//               : () async {
//                   setState(() => isLoading = true);
//                   bool success = await _processData();
//                   setState(() => isLoading = false);
//                   if (success) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ChartsScreen()),
//                     );
//                   }
//                 },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: azul_tanis,
//             foregroundColor: Colors.white,
//             minimumSize: const Size.fromHeight(50),
//           ),
//           child: isLoading
//               ? const CircularProgressIndicator()
//               : const Text(
//                   "Generar Trayectoria",
//                   style: TextStyle(fontWeight: FontWeight.w700),
//                 ),
//         ),
//       ),
//     );
//   }
// }
///////////////////////////////////el de arriba es el bueno 
class Scheduled extends StatefulWidget {
  const Scheduled({super.key});

  @override
  State<Scheduled> createState() => _ScheduledState();
}

class _ScheduledState extends State<Scheduled> {
  final data = ScheduleTasksData();
  late List<ScheduledModel> currentFields;
  late List<TextEditingController> controllers;
  String selectedOption = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentFields = data.getScheduled(selectedOption);
    controllers = List.generate(
      currentFields.length,
      (index) => TextEditingController(),
    );
  }

  void _updateFields() {
    setState(() {
      currentFields = data.getScheduled(selectedOption);
      controllers = List.generate(
        currentFields.length,
        (index) => TextEditingController(),
      );
    });
    Provider.of<TrajectoryProvider>(context, listen: false).updateTipoPozo(selectedOption);
  }

  Future<bool> _processData() async {
    if (selectedOption.isEmpty) {
      _showDialog("Error", "Por favor, seleccione un tipo de pozo.");
      return false;
    }

    if (controllers.any((controller) => controller.text.isEmpty)) {
      _showDialog("Error", "Todos los campos deben estar llenos.");
      return false;
    }

    setState(() => isLoading = true);

    try {
      final service = WellTrajectoryService();
      final tipoPozo = selectedOption;
      final Map<String, double> inputs = {};
      for (int i = 0; i < currentFields.length; i++) {
        inputs[currentFields[i].date] = double.parse(controllers[i].text);
      }

      final resultado = service.calculateWellTrajectory(
        tipoPozo: tipoPozo,
        Nt: inputs['N/S al objetivo'] ?? 0.0,
        Ns: inputs['N/S al conductor'] ?? 0.0,
        Et: inputs['E/W al objetivo'] ?? 0.0,
        Es: inputs['E/W en al conductor'] ?? 0.0,
        BUR: inputs['BUR'] ?? 0.0,
        DOR: inputs['DOR'] ?? 0.0,
        KOP: inputs['KOP'] ?? 0.0,
        TVD: inputs['TVD-P.V.M.V.'] ?? 0.0,
        ProfExt: inputs['Extra'] ?? 0.0,
      );

      setState(() => isLoading = false);

      if (resultado["status"] == "success") {
        final data = resultado["data"] ?? {};
        if (data["Pdes"] != null && data["Angm"] != null && data["At"] != null) {
          Provider.of<TrajectoryProvider>(context, listen: false).updateTrajectoryData(
            summary: {
              "inclinacionMax": data['Angm'].toStringAsFixed(2),
              "azimuth": data['At'].toString(),
              "dlaMax": data['Dlamax'].toString(),
              "md": data['Pdes'].toString(),
            },
            surveyLmd: (data['survey'] as List).asMap().entries.map((entry) => FlSpot((data['survey'] as List)[entry.key].toDouble(), -(data['lmd'] as List)[entry.key].toDouble())).toList(),
            scatter: (data['vs'] as List).asMap().entries.map((entry) => FlSpot((data['vs'] as List)[entry.key].toDouble(), -(data['tvd'] as List)[entry.key].toDouble())).toList(),
            vistHor: (data['Eof'] as List).asMap().entries.map((entry) => FlSpot((data['Eof'] as List)[entry.key].toDouble(), (data['Nof'] as List)[entry.key].toDouble())).toList(),
            table: (data['data'] as List).map((e) => e as Map<String, dynamic>).toList(),
            tipoPozo: selectedOption,
            Pvfci: data["Pvfci"],
            Dhfci: data["Dhfci"],
            Larca: data["Larca"],
            Larcb: data["Larcb"],
            Ltan: data["Ltan"],
            Pvfst: data["Pvfst"],
            Dhfst: data["Dhfst"],
            Pdfci: data["Pdfci"],
            Pdfst: data["Pdfst"],
            Pdfcd: data["Pdfcd"],
            DH: data["DH"],
            angmax: data["Angm"],
            Az: (data['Az'] as List?)?.map((x) => x).toList() ?? [],
            inc: (data['inc'] as List?)?.map((x) => x).toList() ?? [],
          );
          return true;
        } else {
          _showDialog("Error", "Los valores calculados son nulos.");
          return false;
        }
      } else {
        _showDialog("Error", resultado["message"] ?? "Error desconocido en el cálculo.");
        return false;
      }
    } catch (e) {
      setState(() => isLoading = false);
      _showDialog("Error", "No se pudo procesar la trayectoria: $e");
      return false;
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ✅ Parte superior con scroll
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Text(
                      'Selecciona el tipo de pozo:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: azul_tanis, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        for (final option in [
                          {'value': 'j', 'label': 'Pozo J'},
                          {'value': 's', 'label': 'Pozo S'},
                          {'value': 'h', 'label': 'Pozo H'},
                        ])
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedOption = option['value']!;
                                    _updateFields();
                                  });
                                },
                                child: Container(
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: selectedOption == option['value']
                                        ? azul_tanis
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: azul_tanis, width: 1.5),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    option['label']!,
                                    style: TextStyle(
                                      color: selectedOption == option['value']
                                          ? Colors.white
                                          : Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (selectedOption.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Text(
                        'Ingresa tus datos:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 20),

                    for (var index = 0; index < currentFields.length; index++)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: SizedBox(
                          height: 60,
                          child: TextFormField(
                            controller: controllers[index],
                            decoration: InputDecoration(
                              hintText: currentFields[index].date,
                              labelText: currentFields[index].title,
                              labelStyle: const TextStyle(color: Color.fromARGB(255, 8, 8, 8)),
                              hintStyle: const TextStyle(color: Colors.grey),
                              isDense: true,
                              prefixIcon: Icon(currentFields[index].icon, color: azul_tanis),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: azul_tanis, width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: azul_tanis, width: 1.5),
                              ),
                            ),
                            style: const TextStyle(color: Colors.grey),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Este campo no puede estar vacío';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Por favor, ingrese un número válido';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),

                    const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
          ),

          // ✅ Botón visible solo si hay opción seleccionada
          if (selectedOption.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() => isLoading = true);
                        bool success = await _processData();
                        setState(() => isLoading = false);
                        if (success) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChartsScreen()),
                          );
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: azul_tanis,
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(50),
                ),
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "Generar Trayectoria",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
              ),
            ),
        ],
      ),
    );
  }
}