import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:reto4/Proceso/Peticiones.dart';
import 'package:reto4/controlador/ControladorGeneral.dart';
import 'package:reto4/interfaz/listar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'GeoHaroldCORD'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ControladorGeneral control = Get.find();

  void ObtenerPosicion() async {
    Position posicion = await peticiosDB.determinePosition();
    print(posicion.toString());
    control.crgarUnaPosicion(posicion.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Alert(
                        context: context,
                        title: "atencion ",
                        buttons: [
                          DialogButton(
                              color: Colors.orange,
                              child: Text("si"),
                              onPressed: () {
                                peticiosDB.EliminarTodas();
                                control.CargaTodoBD();
                                Navigator.pop(context);
                              }),
                          DialogButton(
                              color: Colors.lightBlue,
                              child: Text("No"),
                              onPressed: () {
                                Navigator.pop(context);
                              })
                        ],
                        desc:
                            "Esta Seguro Que Desea Eliminar Todas Las Ubicaciones")
                    .show();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: listar(),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ObtenerPosicion();

            Alert(
                    title: "ATENCION",
                    desc: "esta seguro que desea almacenar su ubicacion." +
                        control.UnaPosicion +
                        "?",
                    type: AlertType.info,
                    buttons: [
                      DialogButton(
                          color: Colors.green,
                          child: Text("Si"),
                          onPressed: () {
                            peticiosDB.GuardarPosicion(
                                control.UnaPosicion, DateTime.now().toString());
                            control.CargaTodoBD();
                          }),
                      DialogButton(
                          color: Colors.red,
                          child: Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                    context: context)
                .show();

            peticiosDB.GuardarPosicion("2222,12121", DateTime.now().toString());
          },
          child: Icon(Icons.location_on_outlined)),
    );
  }
}
