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

  void set(String newOnce) {
    setState(
      () {
        currentValue = newOnce + ' ${Random().nextInt(100)}';
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primarySwatch: Colors.deepPurple,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Once Made with ❤️'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OnceWidget.showOnEveryNewVersion(
                  builder: () {
                    return const Text('Hey, It new app version, Smile!');
                  },
                  fallback: () {
                    return const Text('Welcome back');
                  },
                ),
                OnceWidget.showOnce(
                  'onceWidget',
                  builder: () {
                    return const Text('Hey, I am the once widget');
                  },
                  fallback: () {
                    return const Text('I am not the one widget');
                  },
                ),
                OnceWidget.showEvery12Hours(
                  'widgetEvery12Hours',
                  builder: () {
                    return const Text('Hey, I am the every12Hours widget');
                  },
                ),
                ElevatedButton(
                  child: const Text("Run On New Version"),
                  onPressed: () {
                    Once.runOnEveryNewVersion(
                      callback: () => set("Hello New Version"),
                      fallback: () => set('Okay its not new version'),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Run Hourly"),
                  onPressed: () {
                    Once.runHourly(
                      "Hourly",
                      callback: () => set("Hello Hourly"),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Run Every 12 Hour"),
                  onPressed: () {
                    Once.runEvery12Hours(
                      "12 Hour",
                      callback: () => set("Hello 12 Hour"),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Run Daily"),
                  onPressed: () {
                    Once.runDaily(
                      "Daily",
                      callback: () => set("Hello Daily"),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Run On New Month"),
                  onPressed: () {
                    Once.runOnNewMonth(
                      "New Month",
                      callback: () => set("Hello New Month"),
                      fallback: () => set("Hello New Month Fallback"),
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text("Run Monthly"),
                  onPressed: () {
                    Once.runMonthly("Monthly x",
                        callback: () => set("Hello Monthly"),
                        fallback: () => set('Hello Monthly Fallback'));
                  },
                ),
                ElevatedButton(
                  child: const Text("Run Evert 5 Sec"),
                  onPressed: () {
                    Once.runCustom(
                      "x",
                      duration: const Duration(seconds: 5),
                      callback: () => set("Hello Custom"),
                    );
                  },
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
      ),
    );
  }
}
