import 'package:event/base/main_app.dart';
import 'package:event/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final customeTheme = CustomThemeProvider();
  await customeTheme.initTheme();
  runApp(ChangeNotifierProvider.value(
    value: customeTheme,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainApp();
  }
}
