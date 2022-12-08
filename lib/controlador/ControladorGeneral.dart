import 'package:get/get.dart';
import 'package:reto4/Proceso/Peticiones.dart';

class ControladorGeneral extends GetxController {
  final Rxn<List<Map<String, dynamic>>> _listaPosiciones =
      Rxn<List<Map<String, dynamic>>>();
  final _unaPosicion = "".obs;

///////////
  void crgarUnaPosicion(String x) {
    _unaPosicion.value = x;
  }

  String get UnaPosicion => _unaPosicion.value;
  ////////////////////////////////////////////////////////////////

  void cargarListaPosiciones(List<Map<String, dynamic>> x) {
    _listaPosiciones.value = x;
  }

  List<Map<String, dynamic>>? get ListaPosiciones => _listaPosiciones.value;

  ////////////////////////////////////////////////////////////////
  Future<void> CargaTodoBD() async {
    final datos = await peticiosDB.MostrarTodasUbicaciones();
    cargarListaPosiciones(datos);
  }
}
