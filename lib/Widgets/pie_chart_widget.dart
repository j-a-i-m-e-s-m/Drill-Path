

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart'; // Ajusta la ruta


class Chart extends StatelessWidget {
  final TrajectoryProvider? provider; // Hacer el provider opcional

  const Chart({super.key, this.provider});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Color.fromARGB(255, 250, 250, 250), // Fondo consistente con el AppBar
            ),
          ),
          Positioned.fill(
            child: provider != null
                ? _buildImage(context, provider!)
                : Consumer<TrajectoryProvider>(
                    builder: (context, provider, child) {
                      return _buildImage(context, provider);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, TrajectoryProvider provider) {
    String imagePath;
    switch (provider.tipoPozo) {
      case 'j':
        // imagePath = 'assets/icons/esq_j.png';
        imagePath = 'assets/icons/1png.png';
        break;
      case 's':
        // imagePath = 'assets/icons/esq_s.png';
        imagePath = 'assets/icons/2png.png';
        break;
      case 'h':
        // imagePath = 'assets/icons/esq_h.png';
        imagePath = 'assets/icons/3png.png';
        break;
      default:
        imagePath = 'assets/icons/drilling.png';
    }
    return Image.asset(
      imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return const Center(
          child: Text(
            'Imagen no disponible',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
/////////////////////imagen principal