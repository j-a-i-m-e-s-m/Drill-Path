import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart'; // Ajusta la ruta
import 'package:trayectoria_gui/Widgets/header_widget.dart';
import 'package:trayectoria_gui/Widgets/side_menu_widget.dart';
import 'package:trayectoria_gui/Widgets/summary_widget.dart';
import 'package:trayectoria_gui/util/responsive.dart';
import 'package:trayectoria_gui/const/const.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart';
import 'package:trayectoria_gui/Widgets/header_widget.dart';
import 'package:trayectoria_gui/util/responsive.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class ImgPrincContent extends StatelessWidget {
//   final TrajectoryProvider? provider;

//   const ImgPrincContent({super.key, this.provider});

//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height;

//     return Container(
//       color: const Color.fromARGB(255, 4, 243, 28),
//       child: Column(
//         children: [
//           HeaderWidget(),
//           Expanded(
//             child: Center(
//               child: Container(
//                 height: screenHeight,
//                 color: backgroundColor,
//                 child: provider != null
//                     ? _buildImage(context, provider!)
//                     : Consumer<TrajectoryProvider>(
//                         builder: (context, provider, child) {
//                           return _buildImage(context, provider);
//                         },
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildImage(BuildContext context, TrajectoryProvider provider) {
//     String imagePath;
//     switch (provider.tipoPozo) {
//       case 'j':
//         imagePath = 'assets/icons/pozojapp_2.png';
//         break;
//       case 's':
//         imagePath = 'assets/icons/pozosapp_2.png';
//         break;
//       case 'h':
//         imagePath = 'assets/icons/pozohapp_2.png';
//         break;
//       default:
//         imagePath = 'assets/icons/drilling.png';
//     }

//     return FittedBox(
//       fit: BoxFit.contain,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(
//           maxWidth: 800,
//           maxHeight: 800,
//         ),
//         child: Image.asset(
//           imagePath,
//           errorBuilder: (context, error, stackTrace) {
//             return const Center(
//               child: Text(
//                 'Imagen no disponible',
//                 style: TextStyle(color: Colors.white),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

//////////////////widget de la imagen, el de arriba es el bueno 

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart';
import 'package:trayectoria_gui/Widgets/header_widget.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImgPrincContent extends StatelessWidget {
  final TrajectoryProvider? provider;

  const ImgPrincContent({super.key, this.provider});

  @override
  Widget build(BuildContext context) {

    return Container(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          const HeaderWidget(),
          Expanded(
            child: Container(
              color: backgroundColor,
              child: provider != null
                  ? _buildImage(context, provider!)
                  : Consumer<TrajectoryProvider>(
                      builder: (context, provider, child) {
                        return _buildImage(context, provider);
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildImage(BuildContext context, TrajectoryProvider provider) {

  final String imagePath;

  switch (provider.tipoPozo) {
    case 'j':
      imagePath = 'assets/icons/T_j.svg';
      break;
    case 's':
      imagePath = 'assets/icons/torre.svg';
      break;
    case 'h':
      imagePath = 'assets/icons/T_h.svg';
      break;
    default:
      imagePath = 'assets/icons/drilling.png';
  }
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    
    
    child: Container(
        width: screenWidth * 0.92,
        height: screenHeight * 0.4,
        decoration: BoxDecoration(
        //color: const Color.fromARGB(255, 8, 8, 8),
        color: const Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(18),
      ),

      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: imagePath.endsWith('.svg')
            ? SvgPicture.asset(
                imagePath,
                fit: BoxFit.fill,
              )
            : Image.asset(
                imagePath,
                fit: BoxFit.fill,
                
              ),
      ),
    ),
  );
}
}
/////////////////////////////////////////////////////////////////////
///
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:trayectoria_gui/util/trajectory_provider.dart';
// import 'package:trayectoria_gui/Widgets/header_widget.dart';
// import 'package:trayectoria_gui/const/const.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ImgPrincContent extends StatelessWidget {
//   final TrajectoryProvider? provider;

//   const ImgPrincContent({super.key, this.provider});

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       color: const Color.fromARGB(255, 255, 255, 255),
//       child: Column(
//         children: [
//           const HeaderWidget(),
//           Expanded(
//             child: Container(
//               color: backgroundColor,
//               child: provider != null
//                   ? _buildImage(context, provider!)
//                   : Consumer<TrajectoryProvider>(
//                       builder: (context, provider, child) {
//                         return _buildImage(context, provider);
//                       },
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Widget _buildImage(BuildContext context, TrajectoryProvider provider) {

//   final String imagePath;

//   switch (provider.tipoPozo) {
//     case 'j':
//       imagePath = 'assets/icons/J_1.svg';
//       break;
//     case 's':
//       imagePath = 'assets/icons/S_12.5x.png';
//       break;
//     case 'h':
//       imagePath = 'assets/icons/H_12.5x.png';
//       break;
//     default:
//       imagePath = 'assets/icons/drilling.png';
//   }
//   final screenWidth = MediaQuery.of(context).size.width;
//   final screenHeight = MediaQuery.of(context).size.height;
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
    
    
//     child: Container(
//         width: screenWidth * 0.92,
//         height: screenHeight * 0.4,
//         decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 8, 8, 8),
//         borderRadius: BorderRadius.circular(18),
//       ),

//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10),
//         child: imagePath.endsWith('.svg')
//             ? SvgPicture.asset(
//                 imagePath,
//                 fit: BoxFit.fill,
//               )
//             : (provider.tipoPozo == 's' || provider.tipoPozo == 'h'|| provider.tipoPozo == 'j')
//               ? Image.asset(
//                   imagePath,
//                   fit: BoxFit.fill,
//                   color: Colors.blue,
//                   colorBlendMode: BlendMode.srcIn,
//                 )
//             : Image.asset(
//                 imagePath,
//                 fit: BoxFit.fill,
                
//               ),
//       ),
//     ),
//   );
// }
// }
