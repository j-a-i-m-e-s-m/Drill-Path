
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';

// class SideMenuWidget extends StatefulWidget {
//   const SideMenuWidget({super.key});

//   @override
//   State<SideMenuWidget> createState() => _SideMenuWidgetState();
// }

// class _SideMenuWidgetState extends State<SideMenuWidget> {
//   int selectedIndex = 0;

//   final List<_MenuItem> menuItems = [
//     _MenuItem(
//       title: "CÁLCULO DE TRAYECTORIA",
//       svgSrc: "assets/icons/lb.svg",
//       route: '/',
//     ),
//     _MenuItem(
//       title: "GRÁFICOS DE LA TRAYECTORIA CALCULADA",
//       svgSrc: "assets/icons/lb.svg",
//       route: '/graficos',
//     ),
//     _MenuItem(
//       title: "DATOS TABULADOS DE LA TRAYECTORIA CALCULADA",
//       svgSrc: "assets/icons/tab.svg",
//       route: '/screenB',
//     ),
//     _MenuItem(
//       title: "PARÁMETROS DE LA TRAYECTORIA DEL POZO",
//       svgSrc: "assets/icons/docs.svg",
//       route: '/puntos',
//     ),
//     _MenuItem(
//       title: "MANUAL DE USUARIO",
//       svgSrc: "assets/icons/docs.svg",
//       route: '/config',
//     ),
    
//   ];

//   Future<void> _launchUrl(String url) async {
//     final Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('No se pudo abrir $url')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         color: cardBackgroundColor,
//         padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 200, // Altura personalizada para el DrawerHeader
//               child: DrawerHeader(
//                 decoration: const BoxDecoration(
//                   color: Colors.transparent,
//                 ),
//                 padding: const EdgeInsets.all(0), // Sin padding
//                 child: Image.asset(
//                   "assets/icons/Tt_log.png",
//                   width: 300, // Ancho más grande
//                   height: 300, // Altura más grande
//                   fit: BoxFit.contain, // Mantiene proporción
//                 ),
//               ),
//             ),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: menuItems.length,
//                 itemBuilder: (context, index) {
//                   final isSelected = selectedIndex == index;
//                   return _buildMenuEntry(menuItems[index], index, isSelected, context);
//                 },
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.all(10),
//               margin: const EdgeInsets.only(top: 10),
//               decoration: BoxDecoration(
//                 color: Colors.white10,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "Contactanos:",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     children: [
//                       const Icon(Icons.facebook, color: Colors.white70, size: 20),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () => _launchUrl("https://www.facebook.com/grupottanis"),
//                         child: Text(
//                           "TTANIS",
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Icon(Icons.email, color: Colors.white70, size: 20),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () => _launchUrl("mailto:tanis.dvc@ttanis.com"),
//                         child: Text(
//                           "tanis.dvc@ttanis.com",
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Icon(Icons.web, color: Colors.white70, size: 20),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () => _launchUrl("https://www.ttanis.com"),
//                         child: Text(
//                           "www.ttanis.com",
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: [
//                       const Icon(Icons.link, color: Colors.white70, size: 20),
//                       const SizedBox(width: 8),
//                       GestureDetector(
//                         onTap: () => _launchUrl("https://www.linkedin.com/company/grupo-ttanis"),
//                         child: Text(
//                           "Grupo TTANIS",
//                           style: TextStyle(color: Colors.white70, fontSize: 14),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 70),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuEntry(_MenuItem item, int index, bool isSelected, BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final showIconOnly = screenWidth < 300; // Mostrar solo íconos si el ancho es menor a 300

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(6),
//         color: isSelected ? Colors.white10 : Colors.transparent,
//       ),
//       child: ListTile(
//         onTap: () {
//           setState(() {
//             selectedIndex = index;
//           });
//           Navigator.pushNamed(context, item.route).then((_) {
//             setState(() {
//               selectedIndex = 0;
//             });
//           });
//         },
//         horizontalTitleGap: 0.0,
//         leading: showIconOnly
//             ? SvgPicture.asset(
//                 item.svgSrc,
//                 colorFilter: ColorFilter.mode(
//                     isSelected ? Colors.white : Colors.white54, BlendMode.srcIn),
//                 height: 20,
//               )
//             : null,
//         title: showIconOnly
//             ? null
//             : Text(
//                 item.title,
//                 style: TextStyle(
//                   color: isSelected ? Colors.white : Colors.white54,
//                   fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                 ),
//               ),
//       ),
//     );
//   }
// }

// class _MenuItem {
//   final String title;
//   final String svgSrc;
//   final String route;

//   const _MenuItem({
//     required this.title,
//     required this.svgSrc,
//     required this.route,
//   });
// }


class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;

  final List<_MenuItem> menuItems = [
    _MenuItem(
      title: "CÁLCULO DE TRAYECTORIA",
      svgSrc: "assets/icons/lb.svg",
      route: '/',
    ),
    _MenuItem(
      title: "GRÁFICOS DE LA TRAYECTORIA GENERADA",
      svgSrc: "assets/icons/lb.svg",
      route: '/graficos',
    ),
    _MenuItem(
      title: "DATOS TABULADOS DE LA TRAYECTORIA GENERADA",
      svgSrc: "assets/icons/tab.svg",
      route: '/screenB',
    ),
    _MenuItem(
      title: "PARÁMETROS DE LA TRAYECTORIA DEL POZO",
      svgSrc: "assets/icons/docs.svg",
      route: '/puntos',
    ),
    _MenuItem(
      title: "MANUAL DE USUARIO",
      svgSrc: "assets/icons/docs.svg",
      route: '/config',
    ),
    
  ];

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo abrir $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 200, 
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding: const EdgeInsets.all(0), // Sin padding
                child: SvgPicture.asset(
                "assets/icons/img.svg",
                fit: BoxFit.contain,
                  ),
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedIndex == index;
                  return _buildMenuEntry(menuItems[index], index, isSelected, context);
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(7),
              margin: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 10,
                ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: azul_tanis, // tu azul corporativo
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Contactanos:",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.facebook, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _launchUrl("https://www.facebook.com/grupottanis"),
                        child: Text(
                          "TTANIS",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _launchUrl("mailto:tanis.dvc@ttanis.com"),
                        child: Text(
                          "tanis.dvc@ttanis.com",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.web, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _launchUrl("https://www.ttanis.com"),
                        child: Text(
                          "www.ttanis.com",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.link, color: Colors.black, size: 20),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _launchUrl("https://www.linkedin.com/company/grupo-ttanis"),
                        child: Text(
                          "Grupo TTANIS",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuEntry(_MenuItem item, int index, bool isSelected, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final showIconOnly = screenWidth < 300; // Mostrar solo íconos si el ancho es menor a 300

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: isSelected ? Colors.white10 : Colors.transparent,
      ),
      child: ListTile(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          Navigator.pushNamed(context, item.route).then((_) {
            setState(() {
              selectedIndex = 0;
            });
          });
        },
        horizontalTitleGap: 0.0,
        leading: showIconOnly
            ? SvgPicture.asset(
                item.svgSrc,
                colorFilter: ColorFilter.mode(
                    isSelected ? Colors.white : Colors.white54, BlendMode.srcIn),
                height: 20,
              )
            : null,
        title: showIconOnly
            ? null
            : Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? azul_tanis : Colors.black,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
      ),
    );
  }
}

class _MenuItem {
  final String title;
  final String svgSrc;
  final String route;

  const _MenuItem({
    required this.title,
    required this.svgSrc,
    required this.route,
  });
}