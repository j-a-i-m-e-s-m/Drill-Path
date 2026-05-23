import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart'; // Importa el provider
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:trayectoria_gui/const/const.dart';
class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  Future<void> _downloadExcel(BuildContext context, List<Map<String, dynamic>> tableData) async {
    if (tableData.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No hay datos para descargar')),
      );
      return;
    }

    // Mostrar diálogo para ingresar el nombre del archivo
    String fileName = 'trayectoria_datos.xlsx'; // Nombre predeterminado
    final TextEditingController fileNameController = TextEditingController(text: fileName);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nombre del archivo'),
        content: TextField(
          controller: fileNameController,
          decoration: const InputDecoration(
            labelText: 'Nombre del archivo',
            hintText: 'Ej: trayectoria_datos.xlsx',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (fileNameController.text.trim().isNotEmpty) {
                fileName = fileNameController.text.trim();
                if (!fileName.endsWith('.xlsx')) {
                  fileName += '.xlsx';
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );

    // Si el usuario canceló el diálogo, salir
    if (fileNameController.text.isEmpty && fileName == 'trayectoria_datos.xlsx') {
      return;
    }

    // Crear el archivo Excel
    var excel = Excel.createExcel();
    Sheet sheet = excel['Trayectoria'];

    // Definir los encabezados
    final headers = [
      'Survey #',
      'MD',
      'Inc',
      'Azm',
      'DLA',
      'TVD',
      'N/S',
      'E/W',
      'DE',
      'DV',
    ];

    // Agregar encabezados a la primera fila
    for (var i = 0; i < headers.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0)).value = TextCellValue(headers[i]);
    }

    // Agregar los datos de tableData
    for (var rowIndex = 0; rowIndex < tableData.length; rowIndex++) {
      final dato = tableData[rowIndex];
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Survey'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex + 1)).value = TextCellValue(dato['MD'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Inc'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Az'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Dla'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: rowIndex + 1)).value = TextCellValue(dato['TVD'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Northing'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Easting'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Eof'].toString());
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: rowIndex + 1)).value = TextCellValue(dato['Nof'].toString());
    }

    try {
      // Seleccionar directorio con file_picker
      String? selectedDirectory = await FilePicker.platform.getDirectoryPath(
        dialogTitle: 'Selecciona una carpeta para guardar el archivo',
      );

      String path;
      if (selectedDirectory == null) {
        // Fallback: Usar directorio predeterminado si no se selecciona uno
        if (Platform.isAndroid || Platform.isIOS) {
          final directory = await getTemporaryDirectory();
          path = '${directory.path}/$fileName';
        } else {
          final directory = await getApplicationDocumentsDirectory();
          path = '${directory.path}/$fileName';
        }
      } else {
        path = '$selectedDirectory/$fileName';
      }

      // Guardar el archivo Excel
      final file = File(path);
      await file.writeAsBytes(excel.encode()!);

      // Móvil: Compartir el archivo
      if (Platform.isAndroid || Platform.isIOS) {
        await Share.shareXFiles([XFile(path)], text: 'Datos de la trayectoria');
      } else {
        // Escritorio: Mostrar mensaje de confirmación
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Archivo guardado en: $path')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar el archivo: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Datos tabulados de la trayectoria calculada'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),///mueve el color del banner de arriba
        foregroundColor:Color.fromARGB(255, 36, 35, 35),
        actions: [
          Consumer<TrajectoryProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.download),
                tooltip: 'Descargar como Excel',
                onPressed: provider.tableData.isEmpty
                    ? null
                    : () => _downloadExcel(context, provider.tableData),
              );
            },
          ),
        ],
      ),
      body: Consumer<TrajectoryProvider>(
        builder: (context, provider, child) {
          final datosTabla = provider.tableData;

          if (datosTabla.isEmpty) {
            return const Center(child: Text('No hay datos disponibles. Completa el formulario primero.'));
          }

          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Scrollbar(
              controller: scrollController,
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: scrollController,
                child: DataTable(
                  columnSpacing: 100,
                  headingRowColor: MaterialStateProperty.all(Colors.white70),
                  columns: const [
                    DataColumn(label: Text('Survey #')),
                    DataColumn(label: Text('MD')),
                    DataColumn(label: Text('Inc')),
                    DataColumn(label: Text('Azm')),
                    DataColumn(label: Text('DLA')),
                    DataColumn(label: Text('TVD')),
                    DataColumn(label: Text('N/S')),
                    DataColumn(label: Text('E/W')),
                    DataColumn(label: Text('DE')),
                    DataColumn(label: Text('DV')),
                  ],
                  rows: datosTabla.map((dato) {
                    return DataRow(color: MaterialStateProperty.all(Colors.white),
                      cells: [
                      DataCell(SelectableText(dato['Survey'].toString())),
                      DataCell(SelectableText(dato['MD'].toString())),
                      DataCell(SelectableText(dato['Inc'].toString())),
                      DataCell(SelectableText(dato['Az'].toString())),
                      DataCell(SelectableText(dato['Dla'].toString())),
                      DataCell(SelectableText(dato['TVD'].toString())),
                      DataCell(SelectableText(dato['Northing'].toString())),
                      DataCell(SelectableText(dato['Easting'].toString())),
                      DataCell(SelectableText(dato['Eof'].toString())),
                      DataCell(SelectableText(dato['Nof'].toString())),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}