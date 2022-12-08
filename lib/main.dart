import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reto4/controlador/ControladorGeneral.dart';

import 'interfaz/home.dart';

void main() {
  Get.put(ControladorGeneral());
  runApp(const MyApp());
}
