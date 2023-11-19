import 'package:flutter/material.dart';
import 'package:simplenewsapp/app.dart';
import 'package:simplenewsapp/di/di.dart';

void main() {
  setupInjection();
  runApp(const App());
}
