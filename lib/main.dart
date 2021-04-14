import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/mapa_page.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';

import 'package:qr_reader/src/providers/ui_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final Map<String, Color> _tema = {
    'tema': Colors.deepPurple,
    'TemaBotonFlotante': Colors.deepPurple,
  };

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => new UiProvider()),
        ChangeNotifierProvider(create: (context) => new ScanListProvider()),
      ],
      child: MaterialApp(
        title: 'Qr Reader',
        initialRoute: 'home',
        debugShowCheckedModeBanner: false,
        routes: {
          'home': (context) => HomePage(),
          'mapa': (context) => MapaPage()
        },
        theme: ThemeData(
            //
            primaryColor: _tema['tema'], //
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: _tema['TemaBotonFlotante'])),
      ),
    );
  }
}
