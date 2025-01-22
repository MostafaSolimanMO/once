import 'dart:math';

import 'package:flutter/material.dart';
import 'package:once/once.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
      ),
      home: const App(),
    );
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String currentValue = 'Hello World';

  @override
  void initState() {
    Once.runOnce(
      'my-app-widget',
      callback: () => set('Once Started'),
    );
    Once.runOnEveryNewVersion(
      callback: () {
        /* What's new in 2.3.2 version? dialog */
      },
      fallback: () {
        /* Navigate to new screen */
      },
    );
    super.initState();
  }

  void set(String newOnce) => setState(
        () => currentValue = '$newOnce ${Random().nextInt(100)}',
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Free Palestine 🇵🇸'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              OnceWidget.showOnEveryNewVersion(
                'newVersionInfoDialog',
                builder: () => const Text(
                  'Hey, It\'s a new app version, Smile!',
                ),
              ),
              OnceWidget.showOnEveryNewBuild(
                'newBuildInfoDialog',
                builder: () => const Text(
                  'Hey, It\'s a new app build, Smile!',
                ),
              ),
              OnceWidget.showOnce(
                'onceWidget',
                builder: () => const Text('Hey, I am the once widget'),
                fallback: () => const Text('I am not the one'),
              ),
              OnceWidget.showEvery12Hours(
                'widgetEvery12Hours',
                builder: () => const Text('Hey, I am the every12Hours'),
              ),
              ElevatedButton(
                child: const Text("Run On New Version"),
                onPressed: () => Once.runOnEveryNewVersion(
                  callback: () => set("Hello New Version"),
                  fallback: () => set('Okay its not new version'),
                ),
              ),
              ElevatedButton(
                child: const Text("Run Hourly"),
                onPressed: () => Once.runHourly(
                  "Hourly",
                  callback: () => set("Hello New Hour"),
                ),
              ),
              ElevatedButton(
                child: const Text("Run Every 12 Hour"),
                onPressed: () => Once.runEvery12Hours(
                  "12 Hour",
                  callback: () => set("Hello New 12 Hour"),
                ),
              ),
              ElevatedButton(
                child: const Text("Run Daily"),
                onPressed: () => Once.runDaily(
                  "Daily",
                  callback: () => set("Hello New Daily"),
                ),
              ),
              ElevatedButton(
                child: const Text("Run On New Month"),
                onPressed: () => Once.runOnNewMonth(
                  "New Month",
                  callback: () => set("Hello New Month"),
                  fallback: () => set("Hello I am not new Month"),
                ),
              ),
              ElevatedButton(
                child: const Text("Run Monthly"),
                onPressed: () => Once.runMonthly(
                  "Monthly x",
                  callback: () => set("Hello Monthly"),
                  fallback: () => set('Hello I am not Monthly'),
                ),
              ),
              ElevatedButton(
                child: const Text("Run Monthly Debug"),
                onPressed: () => Once.runMonthly(
                  "Monthly debug",
                  callback: () => set("Hello Monthly (Debug)"),
                  fallback: () => set('Hello I am not Monthly (Debug)'),
                  debugCallback: true,
                ),
              ),
              ElevatedButton(
                child: const Text("Run Evert 5 Sec"),
                onPressed: () => Once.runCustom(
                  "x",
                  duration: const Duration(seconds: 5),
                  callback: () => set("Hello New 5 Sec"),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                currentValue,
                style: const TextStyle(
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
