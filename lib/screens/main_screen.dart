import 'package:trayectoria_gui/Widgets/Princ_im.dart';
import 'package:trayectoria_gui/Widgets/summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:trayectoria_gui/Widgets/side_menu_widget.dart';
import 'package:trayectoria_gui/util/responsive.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      drawer: !isDesktop
          ? const SizedBox(
              width: 250,
              child: SideMenuWidget(),
            )
          : null,
      endDrawer: isMobile
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
            )
          : null,
      body: SafeArea(
        child: isDesktop
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      child: SideMenuWidget(),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ImgPrincContent(),
                  ),
                  const Expanded(
                    flex: 5,
                    child: SummaryWidget(),
                  ),
                ],
              )////////////////////vista del cel
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: ImgPrincContent(),
                  ),
                 
                  
                  const Expanded(
                    flex: 5,
                    child: SummaryWidget(),
                  ),
                ],
              ),
      ),
    );
  }
}
///////// pantalla principal 