import 'package:finance_app/model/data.dart';
import 'package:finance_app/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:finance_app/view/home_page.dart';
import 'package:device_preview/device_preview.dart';
import 'package:provider/provider.dart';
void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');


  // Hive.registerAdapter(AdddataAdapter());
  // await Hive.openBox<Add_data>('data');
  runApp(DevicePreview(builder: (context) => MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SelectedTypeProvider()),
        ChangeNotifierProvider(create: (context) => DateSelectorProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(colorScheme: lightColorScheme, useMaterial3: true, appBarTheme: myAppBar),
        darkTheme: ThemeData(colorScheme: darkColorScheme, useMaterial3: true, appBarTheme: myAppBar),
        debugShowCheckedModeBanner: false,
        home: const HomePage()
      ),
    );
  }
}