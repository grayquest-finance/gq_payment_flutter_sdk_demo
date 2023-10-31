import 'package:flutter/material.dart';
import 'package:gq_payment_flutter_sdk/gq_payment_flutter_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrayQuest Payment Flutter SDK',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GrayQuest Payment Flutter SDK'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GQPaymentSDK gqPaymentSDK = GQPaymentSDK();

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> auth = {
      "client_id": "<KEY>",
      "client_secret_key": "<KEY>",
      "gq_api_key": "<KEY>"
    };

    Map<String, dynamic> customization = {
      "fee_helper_text": "fee_helper_text",
      "logo_url": "logo_url",
      "theme_color": "252525"
    };

    Map<String, dynamic> pp_config = {
      "slug": "slug",
    };

    Map<String, dynamic> fee_headers = {"payable_0": 100};

    Map<String, dynamic> config = {
      "auth": auth,
      "student_id": "demo_123457",
      "customer_number": "8423560119",
      "env": "test",
      // "customization": customization,
      // "pp_config": pp_config,
      // "fee_headers": fee_headers
    };

    Map<String, dynamic> prefill = {};

    gqPaymentSDK.initiate(context, onSuccess: (data) {
      // Handle data received from WebView
      print('Received Success data in APP: $data');
    }, onFailed: (data) {
      print('Received Success data in APP: $data');
    }, onCancel: (data) {
      print('Received Success data in APP: $data');
    });


    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {
                gqPaymentSDK.checkout(context, config, prefill);
              },
              child: const Text('Masira Darvesh - UAT Environment'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 2),
              onPressed: () {

              },
              child: const Text('Enter Manually'),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
