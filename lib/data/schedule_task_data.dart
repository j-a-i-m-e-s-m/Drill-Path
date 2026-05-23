

import 'package:trayectoria_gui/model/schedule_model.dart';


class ScheduleTasksData {
  final Map<String, List<ScheduledModel>> scheduledByType = {
    'j': const [
      ScheduledModel(title: "Coordenadas UTM N/S de la superficie:", date: 'N/S al conductor'),
      ScheduledModel(title: "Coordenadas UTM E/W de la superficie:", date: 'E/W en al conductor'),      
      ScheduledModel(title: "Coordenadas UTM N/S al final de la trayectoria:", date: 'N/S al objetivo'),
      ScheduledModel(title: "Coordenadas UTM E/W al final de la trayectoria:", date: 'E/W al objetivo'),
      ScheduledModel(title: "Inicio de desviación m:", date: 'KOP'),      
      ScheduledModel(title: "Ritmo de incremento /30m:", date: 'BUR'),
      ScheduledModel(title: "Profundidad vertical al objetivo m:", date: 'TVD-P.V.M.V.'),
      
    ],
    's': const [
      
      ScheduledModel(title: "Coordenadas UTM N/S de la superficie:", date: 'N/S al conductor'),
      ScheduledModel(title: "Coordenadas UTM E/W de la superficie:", date: 'E/W en al conductor'),
      ScheduledModel(title: "Coordenadas UTM N/S al final del decremento:", date: 'N/S al objetivo'),
      ScheduledModel(title: "Coordenadas UTM E/W al final del decremento:", date: 'E/W al objetivo'),
      ScheduledModel(title: "Inicio de desviación m:", date: 'KOP'),
      ScheduledModel(title: "Ritmo de incremento /30m:", date: 'BUR'),
      ScheduledModel(title: "Ritmo de reducción /30m:", date: 'DOR'),
      ScheduledModel(title: "Profundidad vertical al objetivo m:", date: 'TVD-P.V.M.V.'),
      ScheduledModel(title: "Distancia después de la curva/decremento:", date: 'Extra'),
    ],
    'h': const [
      ScheduledModel(title: "Coordenadas UTM N/S al final de la curva:", date: 'N/S al objetivo'),
      ScheduledModel(title: "Coordenadas UTM E/W al final de la curva:", date: 'E/W al objetivo'),
      ScheduledModel(title: "Coordenadas UTM N/S de la superficie:", date: 'N/S al conductor'),   
      ScheduledModel(title: "Coordenadas UTM E/W de la superficie:", date: 'E/W en al conductor'),
      ScheduledModel(title: "Ritmo de incremento /30m:", date: 'BUR'),
      ScheduledModel(title: "Inicio de desviación m:", date: 'KOP'),
      ScheduledModel(title: "Profundidad vertical al objetivo m:", date: 'TVD-P.V.M.V.'),
      ScheduledModel(title: "Distancia después de la curva/decremento:", date: 'Extra'),
    ],
  };

  List<ScheduledModel> getScheduled(String tipoPozo) {
    return scheduledByType[tipoPozo] ?? []; // Fallback a tipo J si no se encuentra
  }
}