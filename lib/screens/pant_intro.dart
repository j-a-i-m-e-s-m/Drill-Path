import 'package:flutter/material.dart';
import 'package:trayectoria_gui/const/const.dart';
import 'package:trayectoria_gui/screens/main_screen.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    var d = const Duration(seconds: 2);//aqui se establece el tiempo de proyeccion 
    Future.delayed(d, () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) =>  MainScreen()),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/Log2_b.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // const Align(
          //   alignment: Alignment.bottomCenter,
          //   child: Padding(
          //     padding: EdgeInsets.all(70),///70
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: [
          //         ListTile(
          //           titleTextStyle: TextStyle(color: LineColor),
          //           title: Text(
          //             "DRILLING PATH",
          //             style: TextStyle(fontSize: 28,
          //             fontWeight: FontWeight.bold,
          //             ),
          //             textAlign: TextAlign.center,
          //           ),
          //           // subtitle: Text(
          //           //   "Cargando",
          //           //   style: TextStyle(fontSize: 20, 
          //           //   color: Color.fromARGB(255, 252, 252, 252),
          //           //   fontWeight: FontWeight.bold,
          //           //   ),
          //           //   textAlign: TextAlign.center,
          //           // ),
          //         ),
          //         SizedBox(height: 20),
          //         CircularProgressIndicator(
          //           color: backgroundColor,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
