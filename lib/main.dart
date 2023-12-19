import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gq_payment_flutter_sdk/gq_payment_flutter_sdk.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}
var globalContext;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    globalContext = context;
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

  final TextEditingController _clientIDController = TextEditingController();
  final TextEditingController _secretKeyController = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  final TextEditingController _environmentController = TextEditingController();
  final TextEditingController _studentIDController = TextEditingController();
  final TextEditingController _customerNumberController =
      TextEditingController();
  final TextEditingController _ppConfigController = TextEditingController();
  final TextEditingController _feeHeaderController = TextEditingController();
  final TextEditingController _prefillObjController = TextEditingController();

  Map<String, dynamic> prefill = {};
  Map<String, dynamic> pp_config = {};
  Map<String, dynamic> fee_headers = {};

  String clientID = '';
  String secretKey = '';
  String apiKey = '';
  String environment = '';
  String studentID = '';
  String customerNumber = '';
  String ppConfig = '';
  String feeHeader = '';
  String prefillObj = '';

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? getConfig() {
      try {
        Map<String, dynamic> auth = {
          "client_id": clientID,
          "client_secret_key": secretKey,
          "gq_api_key": apiKey
        };

        // Map<String, dynamic> auth = {
        //   // "client_id": "GQ-bf594dca-755d-4d82-9cff-954b20596e10",
        //   // "client_secret_key": "ebb8ab06-1fed-4889-ba97-ab3ec894f5cf",
        //   // "gq_api_key": "5ad5d193-18b8-4537-8a31-61bef5fdf9a9"
        //
        // // "client_id": "GQ-e5dc1488-9b07-40f5-8b65-ca3999f5a487",
        // //   "client_secret_key": "cc6e45d514251e077389154754b981972812e45e",
        // //   "gq_api_key": "6d3e82ec78d2b045275ab5c40fd2b158e8f17dbd"
        // };

        // Map<String, dynamic> customization = {
        //   "fee_helper_text": "fee_helper_text",
        //   "logo_url": "logo_url",
        //   "theme_color": "252525"
        // };

        // if(ppConfig.isNotEmpty) {
        //   pp_config = json.decode(ppConfig);
        // }

        // Map<String, dynamic> pp_config = {
        //   "slug": "arjun-gile",
        //   // "slug": "mahalakshmi",
        //   // "slug": "kl-vijaywada",
        // };

        // if(feeHeader.isNotEmpty) {
        //   fee_headers = json.decode(feeHeader);
        // }

        // Map<String, dynamic> fee_headers = {
        //   "Payable_fee_EMI": 150000,
        //   "Payable_fee_Auto_Debit": 100,
        //   "Payable_fee_PG": 10.00
        // };

        Map<String, dynamic> configObj = {
          "auth": auth,
          "student_id": studentID,
          if (customerNumber.isNotEmpty) "customer_number": customerNumber,
          "env": environment,
          // "customization": customization,
          // "pp_config": pp_config,
          // "fee_headers": fee_headers
        };

        if(ppConfig.isNotEmpty) {
          pp_config = json.decode(ppConfig);
          configObj["pp_config"] = pp_config;
        }

        if(feeHeader.isNotEmpty) {
          fee_headers = json.decode(feeHeader);
          configObj["fee_headers"] = fee_headers;
        }

        Map<String, dynamic> student_details = {
          "student_first_name": "First Name",
          "student_last_name": "Last Name"
        };

        Map<String, dynamic> customer_details = {
          "customer_email": "test@gmail.com"
        };

        Map<String, dynamic> prefill = {
          "student_details": student_details,
          "customer_details": customer_details
        };

        return configObj;
      } catch (e) {
        print('Error decoding JSON: $e');
      }

      return null;
    }

    gqPaymentSDK.initiate(context, onSuccess: (data) {
      print('Success data: $data');
      // showPopupDialog(context, data.toString());
      Fluttertoast.showToast(
          msg: data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          fontSize: 16.0
      );
      // Navigator.pop(context);
    }, onFailed: (data) {
      print('Failed data: $data');
      // showPopupDialog(context, data.toString());
      Fluttertoast.showToast(
          msg: data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          fontSize: 16.0
      );
    }, onCancel: (data) {
      print('Cancel data: $data');
      Fluttertoast.showToast(
          msg: data.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.black,
          backgroundColor: Colors.white,
          fontSize: 16.0
      );
      // showPopupDialog(globalContext, data.toString());
    });

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _clientIDController,
              decoration: const InputDecoration(labelText: 'Client ID *'),
              onChanged: (value) {
                setState(() {
                  clientID = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _secretKeyController,
              decoration:
                  const InputDecoration(labelText: 'Client Secret Key *'),
              onChanged: (value) {
                setState(() {
                  secretKey = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _apiKeyController,
              decoration: const InputDecoration(labelText: 'GQ API Key *'),
              onChanged: (value) {
                setState(() {
                  apiKey = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Select Environment *',
              textAlign: TextAlign.left,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: RadioListTile(
                    value: 'test',
                    groupValue: environment,
                    onChanged: (value) {
                      setState(() {
                        environment = value!;
                      });
                    },
                    title: const Text('UAT'),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: 'staging',
                    groupValue: environment,
                    onChanged: (value) {
                      setState(() {
                        environment = value!;
                      });
                    },
                    title: const Text('Stage'),
                  ),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Expanded(
                child: RadioListTile(
                  value: 'preprod',
                  groupValue: environment,
                  onChanged: (value) {
                    setState(() {
                      environment = value!;
                    });
                  },
                  title: const Text('Pre-Prod'),
                ),
              ),
              Expanded(
                child: RadioListTile(
                  value: 'live',
                  groupValue: environment,
                  onChanged: (value) {
                    setState(() {
                      environment = value!;
                    });
                  },
                  title: const Text('Live'),
                ),
              ),
            ]),
            const SizedBox(height: 16.0),
            TextField(
              controller: _studentIDController,
              decoration: const InputDecoration(labelText: 'Student ID *'),
              onChanged: (value) {
                setState(() {
                  studentID = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _customerNumberController,
              decoration:
                  const InputDecoration(labelText: 'Customer Mobile Number'),
              onChanged: (value) {
                setState(() {
                  customerNumber = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _ppConfigController,
              decoration: const InputDecoration(
                  labelText: 'Payment Pages Configuration'),
              onChanged: (value) {
                setState(() {
                  ppConfig = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _feeHeaderController,
              decoration: const InputDecoration(labelText: 'Fee Headers'),
              onChanged: (value) {
                setState(() {
                  feeHeader = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _prefillObjController,
              decoration: const InputDecoration(labelText: 'Prefill Object'),
              onChanged: (value) {
                setState(() {
                  prefillObj = value;
                });
              },
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: GestureDetector(
            //     onTap: () {
            //       print("PrefillJSONExample: ${prefillJSONExample()}");
            //      samplePrefillBox();
            //     },
            //     child: new Text("Sample Example"),
            //   ),
            // ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {
                      print("ClientId: $clientID");
                      print("SecretKey: $secretKey");
                      print("ApiKey: $apiKey");
                      print("Environment: $environment");
                      print("StudentId: $studentID");
                      print("CustomerNumber: $customerNumber");
                      print("PpConfig: $ppConfig");
                      print("FeeHeader: $feeHeader");
                      print("PrefillObj: $prefillObj");
                      print("ConfigObject: ${getConfig()}");
                      if (prefillObj.isNotEmpty) {
                        prefill = json.decode(prefillObj);
                      }
                      // Map<String, dynamic> prefillObject = json.decode(prefillObj);
                      print("PrefillObjectSend: $prefill");
                      gqPaymentSDK.checkout(context, getConfig(),
                          prefill); // Open GrayQuest SDK and pass config and prefill data
                    },
                    child: const Text('Open GQ SDK'),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 2),
                    onPressed: () {
                      customDialog();
                      // _clientIDController.text =
                      //     "GQ-e2daf990-c020-4162-9a2f-da9ec6423be5";
                      // clientID = _clientIDController.text;
                      // _secretKeyController.text =
                      //     "51028d07-97aa-4498-8379-5c2e8e4d3716";
                      // secretKey = _secretKeyController.text;
                      // _apiKeyController.text =
                      //     "08051930-3621-42ff-858b-cb86383df2d5";
                      // apiKey = _apiKeyController.text;
                      // // environment = "test";
                      // _studentIDController.text = "demo_123456";
                      // studentID = _studentIDController.text;
                      // _customerNumberController.text = "8425960119";
                      // customerNumber = _customerNumberController.text;
                      // _ppConfigController.text =
                      //     "{\"slug\":\"masira-darvesh-ayc-two\"}";
                      // ppConfig = _ppConfigController.text;
                      // _feeHeaderController.text =
                      //     "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                      // feeHeader = _feeHeaderController.text;
                    },
                    child: const Text('Prefill'),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
              ],
            ),
            const SizedBox(
              height: 16.0,
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void samplePrefillBox(){
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(10.0),
              child: Container(
                width: 300,
                child: Center(
                  child: Text(prefillJSONExample()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(onPressed: (){
                  _prefillObjController.text =
                  prefillJSONExample();
                  prefillObj = _prefillObjController.text;
                  Navigator.of(context).pop();
                }, child: Text("Apply"))
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  void customDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "masira-darvesh-gile || UAT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _clientIDController.text =
                            "GQ-0d2ed24e-cc1f-400b-a4e3-7208c88b99b5";
                        clientID = _clientIDController.text;
                        _secretKeyController.text =
                            "a96dd7ea-7d4a-4772-92c3-ac481713be4a";
                        secretKey = _secretKeyController.text;
                        _apiKeyController.text =
                            "b59bf799-2a82-4298-b901-09c512ea4aaa";
                        apiKey = _apiKeyController.text;
                        // environment = "test";
                        _ppConfigController.text =
                            "{\"slug\":\"masira-darvesh-gile\"}";
                        ppConfig = _ppConfigController.text;
                        _feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = _feeHeaderController.text;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "masira-d || STAGING",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _clientIDController.text =
                            "GQ-9ebd69b1-75f6-467f-91f1-cb07dbc0d7a7";
                        clientID = _clientIDController.text;
                        _secretKeyController.text =
                            "dafb9543-2041-42e2-a7a4-f30b977a749e";
                        secretKey = _secretKeyController.text;
                        _apiKeyController.text =
                            "c3f65108-5881-4075-9a0e-3a86a468c77b";
                        apiKey = _apiKeyController.text;
                        // environment = "test";
                        _ppConfigController.text = "{\"slug\":\"masira-d\"}";
                        ppConfig = _ppConfigController.text;
                        _feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = _feeHeaderController.text;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "masira-darvesh-ayc-two || UAT || UNIPG",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _clientIDController.text =
                            "GQ-e2daf990-c020-4162-9a2f-da9ec6423be5";
                        clientID = _clientIDController.text;
                        _secretKeyController.text =
                            "51028d07-97aa-4498-8379-5c2e8e4d3716";
                        secretKey = _secretKeyController.text;
                        _apiKeyController.text =
                            "08051930-3621-42ff-858b-cb86383df2d5";
                        apiKey = _apiKeyController.text;
                        // environment = "test";
                        _ppConfigController.text =
                            "{\"slug\":\"masira-darvesh-ayc-two\"}";
                        ppConfig = _ppConfigController.text;
                        _feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = _feeHeaderController.text;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Divider(
                color: Colors.black26,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    "masira-darvesh-chinchwad || PROD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal),
                  )),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _clientIDController.text =
                            "GQ-e7b751fb-d991-4606-b5b2-ae40c224947f";
                        clientID = _clientIDController.text;
                        _secretKeyController.text =
                            "b15bee26-7a4f-475b-b375-8b761ac0f6f7";
                        secretKey = _secretKeyController.text;
                        _apiKeyController.text =
                            "e927736e-d685-486b-ab8b-6cddedef0ea8";
                        apiKey = _apiKeyController.text;
                        // environment = "test";
                        _ppConfigController.text =
                            "{\"slug\":\"masira-darvesh-chinchwad\"}";
                        ppConfig = _ppConfigController.text;
                        _feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = _feeHeaderController.text;
                        Navigator.of(context).pop();
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => errorDialog);
  }

  void showPopupDialog(BuildContext context, String message) {
    showDialog(
      context: globalContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  String prefillJSONExample() {
    Map<String, dynamic> student = {
      "student_first_name": "<student_first_name>",
      "student_last_name": "<student_last_name>",
      "student_type": "EXISTING || NEW"
    };

    Map<String, dynamic> customer = {
      "customer_first_name": "<customer_first_name>",
      "customer_middle_name": "<customer_middle_name>",
      "customer_last_name": "<customer_last_name>",
      "customer_dob": "<customer_dob>",
      "customer_gender": "MALE || FEMALE",
      "customer_email": "<customer_email>",
      "customer_marital_status": "MARRIED || DIVORCED || OTHERS"
    };

    Map<String, dynamic> kyc = {"pan_number": "<pan_number>"};

    Map<String, dynamic> residential = {
      "residential_addr_line_1": "<residential_addr_line_1>",
      "residential_addr_line_2": "<residential_addr_line_2>",
      "residential_type":
          "SELF OWNED || RENTED || COMPANY PROVIDED || PAYING GUEST",
      "residential_pincode": "<residential_pincode>",
      "residential_city": "<residential_city>",
      "residential_state": "<residential_state>"
    };

    Map<String, dynamic> employment = {
      "income_type": "SALARIED || SELF EMPLOYED",
      "employer_name": "<employer_name>",
      "work_experience": "<work_experience>",
      "net_monthly_salary": "<net_monthly_salary>",
      "business_name": "<business_name>",
      "business_annual_income": "<business_annual_income>",
      "business_description": "<business_description>",
      "years_of_current_business": "<years_of_current_business>",
    };

    Map<String, dynamic> notes = {
      "roll_no": "Ixxxxxxxx5",
      "admission_slno": 10000056,
      "branch_id": 456
    };

    Map<String, dynamic> prefillJsonExample = {
      "student_details": student,
      "customer_details": customer,
      "kyc_details": kyc,
      "residential_details": residential,
      "employment_details": employment,
      "notes": notes
    };

    return prefillJsonExample.toString();
  }
}
