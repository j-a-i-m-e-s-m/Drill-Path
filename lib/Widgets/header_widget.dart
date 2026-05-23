
//port 'package:fitness_dashboard_ui/util/responsive.dart';
import 'package:trayectoria_gui/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:google_fonts/google_fonts.dart';
// class HeaderWidget extends StatelessWidget {
//   const HeaderWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         if (!Responsive.isDesktop(context))
        
//           Padding(
//             padding: const EdgeInsets.only(right: 20),
//             child: InkWell(
//               onTap: () => Scaffold.of(context).openDrawer(),
//               child: Padding(
//                 padding: const EdgeInsets.all(4.0),
//                 child: Icon(
//                   Icons.menu,
//                   color: Colors.white,
//                   size: 60,
//                 ),
//               ),
//             ),
//           ),
//         if (!Responsive.isDesktop(context))  
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10), // Espaciado entre la imagen y los íconos
//             child: Image.asset(
//                   'assets/icons/download.png', 
//                   width: 80, 
//                   height: 60, 
//             ),
//           ),
//         // if (!Responsive.isDesktop(context))  
//         //   Padding(
//         //     padding: const EdgeInsets.symmetric(horizontal: 10), // Espaciado entre la imagen y los íconos
//         //     child: Image.asset(
//         //           'assets/icons/GT.png', 
//         //           width: 80, 
//         //           height: 60, 
//         //     ),
//         //   ),  

      
//         // if (!Responsive.isDesktop(context))
//         //   Row(
//         //     children: [        
//         //       InkWell(
//         //         onTap: () => Scaffold.of(context).openEndDrawer(),
//         //         child: Padding(
//         //         padding: const EdgeInsets.all(4.0),
//         //         child: Icon(
//         //           Icons.table_view,
//         //           color: Colors.white,
//         //           size: 60,
//         //         ),
//         //       ),
//         //       ),
//         //     ],
//         //   ),
//       ],
//     );
//   }
// }

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.menu,
                      color: azul_tanis,
                      size: 35,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "MENÚ", 
                      style: GoogleFonts.montserrat(
                        color: azul_tanis,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        // if (!Responsive.isDesktop(context))
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10),
        //     child: Image.asset(
        //       'assets/icons/download.png',
        //       width: 80,
        //       height: 60,
        //     ),
        //   ),
      ],
    );
  }
}
