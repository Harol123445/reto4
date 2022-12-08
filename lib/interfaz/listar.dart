import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto4/Proceso/Peticiones.dart';

import 'package:reto4/controlador/ControladorGeneral.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class listar extends StatefulWidget {
  const listar({super.key});

  @override
  State<listar> createState() => _listarState();
}

class _listarState extends State<listar> {
  ControladorGeneral control = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    control.CargaTodoBD();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          child: control.ListaPosiciones?.isEmpty == false
              ? ListView.builder(
                  itemCount: control.ListaPosiciones?.length,
                  itemBuilder: ((BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                      leading: Icon(Icons.location_searching_rounded),
                      trailing: IconButton(
                          onPressed: () {
                            Alert(
                                    type: AlertType.warning,
                                    context: context,
                                    title: "ATENCION",
                                    buttons: [
                                      DialogButton(
                                          color: Colors.green,
                                          child: Text("Si"),
                                          onPressed: () {
                                            peticiosDB.EliminarPosicion(control
                                                .ListaPosiciones![index]["id"]);
                                            control.CargaTodoBD();
                                            Navigator.pop(context);
                                          }),
                                      DialogButton(
                                          color: Colors.red,
                                          child: Text("No"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          })
                                    ],
                                    desc: "esta seguro que desea Eliminar?")
                                .show();
                            peticiosDB.EliminarPosicion(
                                control.ListaPosiciones![index]["id"]);
                            control.CargaTodoBD();
                          },
                          icon: Icon(Icons.delete_outline)),
                      title:
                          Text(control.ListaPosiciones![index]["coordenadas"]),
                      subtitle: Text(control.ListaPosiciones![index]["fecha"]),
                    ));
                  }))
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
