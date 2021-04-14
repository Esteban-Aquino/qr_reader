import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/src/pages/direcciones_page.dart';
import 'package:qr_reader/src/pages/mapas_page.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';
import 'package:qr_reader/src/providers/ui_provider.dart';
import 'package:qr_reader/src/widgets/custom_navigatorbar.dart';
import 'package:qr_reader/src/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
              icon: Icon(Icons.delete_forever), //
              onPressed: () {
                borrarTodo(context);
              })
        ],
        elevation: 0,
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButtom(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  borrarTodo(BuildContext context) {
    print('Borrar');
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);
    scanListProvider.borrarTodos();
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    // cambiar para mostrar Contenido
    final currentIndex = uiProvider.selectedMenuOpt;

    // Leer Base de datos
    //final tempScan = new ScanModel(valor: 'http://leaderbrokers.com.py');
    // Insertar, devuelve el id de la insercion
    //final intTemp = DBProvider.db.nuevoScan(tempScan);

    // Consulta por id
    /* DBProvider.db.getScanById(2).then((scan) => {
          if (scan != null) {print(scan.valor)}
        });*/

    // Consultar todo
    //DBProvider.db.getTodosLosScans().then(print);

    //DBProvider.db.deleteAllScan().then(print);

    //Usar el scanlist provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}
