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

  void set(String newOnce) {
    setState(() {
      currentValue = newOnce + ' ${Random().nextInt(100)}';
    });
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
                ElevatedButton(
                    child: const Text("Run On New Version"),
                    onPressed: () {
                      Once.runOnce("New Version", () {
                        set("Hello New Version");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Only Once"),
                    onPressed: () {
                      Once.runOnce("Once", () {
                        set("Hello Only Once");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Hourly"),
                    onPressed: () {
                      Once.runHourly("Hourly", () {
                        set("Hello Hourly");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Every 12 Hour"),
                    onPressed: () {
                      Once.runEvery12Hours("12 Hour", () {
                        set("Hello 12 Hour");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Daily"),
                    onPressed: () {
                      Once.runDaily("Daily", () {
                        set("Hello Daily");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Weekly"),
                    onPressed: () {
                      Once.runWeekly("Weekly", () {
                        set("Hello Weekly");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run On New Month"),
                    onPressed: () {
                      Once.runOnNewMonth("New Month", () {
                        set("Hello New Month");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Monthly"),
                    onPressed: () {
                      Once.runMonthly("Monthly", () {
                        set("Hello Monthly");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Yearly"),
                    onPressed: () {
                      Once.runYearly("Yearly", () {
                        set("Hello Yearly");
                      });
                    }),
                ElevatedButton(
                    child: const Text("Run Evert 5 Sec"),
                    onPressed: () {
                      Once.runCustom(
                        "Custom",
                        () => set("Hello Custom"),
                        duration: const Duration(seconds: 5),
                      );
                    }),
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