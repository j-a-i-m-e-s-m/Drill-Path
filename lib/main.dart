
// import 'package:flutter/material.dart';
// import 'package:trayectoria_gui/screens/main_screen.dart';
// import 'package:trayectoria_gui/screens/ScreenA.dart';
// import 'package:trayectoria_gui/screens/ScreenB.dart';
// import 'package:trayectoria_gui/screens/pant_graficos.dart';
// import 'package:trayectoria_gui/screens/pant_intro.dart';
// import 'dart:io';
// import 'package:window_manager/window_manager.dart';
// import 'package:provider/provider.dart';
// import 'package:trayectoria_gui/util/trajectory_provider.dart';
// import 'package:trayectoria_gui/Widgets/TrajectoryTableScreen.dart';



// // Future<void> startFlaskServer() async {
// //   try {
// //     var shell = Shell(); // Descomenta si usas Shell
// //     if (Platform.isWindows) {
// //       await shell.run('start /B pythonw.exe app.py');
// //       print("Servidor Flask iniciado en segundo plano.");
// //     } else {
// //       await shell.run('python app.py &');
// //       print("Servidor Flask iniciado en segundo plano.");
// //     }
// //   } catch (e) {
// //     print("Error al iniciar Flask: $e");
// //   }
// // }

// // Future<void> stopFlaskServer() async {
// //   try {
// //     var shell = Shell("pkill -f 'python app.py'");
// //       print("Servidor Flask detenido.");
// //     }
// //   } catch (e) {
// //     print("Error al detener Flask: $e");
// //   }
// // }

// // void unawaited(Future<void> future) {
// //   future.catchError((e) => print("Error en unawaited: $e"));
// // }

// ////////////////////////////////////////////////////////////////////////////////(); // Descomenta si usas Shell
// //     if (Platform.isWindows) {
// //       await shell.run('taskkill /F /IM pythonw.exe /T');
// //       print("Servidor Flask detenido.");
// //     } else {
// //       await shell.run

// //import 'package:flutter/material.dart';
// //import 'package:provider/provider.dart';
// //import 'package:window_manager/window_manager.dart';
// //import 'dart:io';
// // import 'package:trayectoria_gui/util/trajectory_provider.dart';
// // import 'package:trayectoria_gui/Widgets/TrajectoryTableScreen.dart';
// // import 'package:trayectoria_gui/screens/pant_graficos.dart';
// // import 'package:trayectoria_gui/screens/pant_intro.dart';
// import 'package:google_fonts/google_fonts.dart';
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
//     await windowManager.ensureInitialized();
//     WindowOptions windowOptions = const WindowOptions(
//       size: Size(1366, 768),
//       center: true,
//       title: 'Drilling Path',////////////////////////////////////////////////////////////////////
//     );
//     await windowManager.waitUntilReadyToShow(windowOptions, () async {
//       await windowManager.show();
//       await windowManager.focus();
//     });
//   }

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   //_MyAppState createState() => _MyAppState();
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> with WindowListener {
//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
//       windowManager.addListener(this);
//     }
//   }

//   @override
//   void dispose() {
//     if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
//       windowManager.removeListener(this);
//     }
//     super.dispose();
//   }

//   @override
//   void onWindowClose() async {
//     await windowManager.destroy();
//     exit(0);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => TrajectoryProvider(),
//       child: Builder(
//         builder: (context) {
//           return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Drilling Path',
//             theme: ThemeData(
//               scaffoldBackgroundColor: Colors.grey[900],
//               textTheme: GoogleFonts.montserratTextTheme(),
//               brightness: Brightness.dark,
//             ),
//             initialRoute:'splash', //'/',
//             routes: {
//               'splash':(context)=> const SplashScreen(),
//               '/': (context) => const MainScreen(),
//               '/screenA': (context) => const MainScreen(),
//               '/screenB': (context) => const ScreenB(),
//               '/config': (context) => const MyPdfViewer(),
//               '/puntos': (context) => const TrajectoryTableScreen(),
//               '/graficos': (context) => const ChartsScreen(),
//             },
//           );
//         },
//       ),
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////////////////////
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';
import 'dart:io' show Platform, exit;

import 'package:trayectoria_gui/screens/main_screen.dart';
import 'package:trayectoria_gui/screens/ScreenB.dart';
import 'package:trayectoria_gui/screens/pant_graficos.dart';
import 'package:trayectoria_gui/screens/pant_intro.dart';
import 'package:trayectoria_gui/util/trajectory_provider.dart';
import 'package:trayectoria_gui/Widgets/TrajectoryTableScreen.dart';
import 'package:trayectoria_gui/screens/ScreenA.dart';

/// true solo en Windows, macOS y Linux (nunca en web ni móvil)
bool get _isDesktop =>
    !kIsWeb && (Platform.isWindows || Platform.isMacOS || Platform.isLinux);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (_isDesktop) {
    await windowManager.ensureInitialized();
    const WindowOptions windowOptions = WindowOptions(
      size: Size(1366, 768),
      center: true,
      title: 'Drilling Path',
    );
    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WindowListener {
  @override
  void initState() {
    super.initState();
    if (_isDesktop) {
      windowManager.addListener(this);
    }
  }

  @override
  void dispose() {
    if (_isDesktop) {
      windowManager.removeListener(this);
    }
    super.dispose();
  }

  @override
  void onWindowClose() async {
    await windowManager.destroy();
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TrajectoryProvider(),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Drilling Path',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.grey[900],
              textTheme: GoogleFonts.montserratTextTheme(),
              brightness: Brightness.dark,
            ),
            initialRoute: 'splash',
            routes: {
              'splash': (context) => const SplashScreen(),
              '/': (context) => const MainScreen(),
              '/screenA': (context) => const MainScreen(),
              '/screenB': (context) => const ScreenB(),
              '/config': (context) => const MyPdfViewer(),
              '/puntos': (context) => const TrajectoryTableScreen(),
              '/graficos': (context) => const ChartsScreen(),
            },
          );
        },
      ),
    );
  }
}