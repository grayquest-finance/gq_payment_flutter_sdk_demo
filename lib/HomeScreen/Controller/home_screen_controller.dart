import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gq_payment_flutter_sdk/gq_payment_flutter_sdk.dart';

class HomeScreenController extends GetxController {
  final GQPaymentSDK gqPaymentSDK = GQPaymentSDK();

  final TextEditingController clientIDController = TextEditingController();
  final TextEditingController secretKeyController = TextEditingController();
  final TextEditingController apiKeyController = TextEditingController();
  final TextEditingController environmentController = TextEditingController();
  final TextEditingController studentIDController = TextEditingController();
  final TextEditingController customerNumberController =
      TextEditingController();
  final TextEditingController ppConfigController = TextEditingController();
  final TextEditingController feeHeaderController = TextEditingController();
  final TextEditingController prefillObjController = TextEditingController();
  final TextEditingController referenceIdController = TextEditingController();

  RxString environment = ''.obs;
  String customerNumber = '';
  Map<String, dynamic> prefill = {};
  String feeHeader = '';
  String prefillObj = '';
  final RxString data = "".obs;

  void samplePrefillBox() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 300,
                child: Center(
                  child: Text(prefillJSONExample()),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                    onPressed: () {
                      prefillObjController.text = prefillJSONExample();
                      prefillObj = prefillObjController.text;
                      Get.back();
                    },
                    child: const Text("Apply"))),
          ],
        ),
      ),
    );
    showDialog(
        context: Get.context!, builder: (BuildContext context) => errorDialog);
  }

  void customDialog() {
    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
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
                        clientIDController.text =
                            "<KEY>";

                        secretKeyController.text =
                            "<KEY>";

                        apiKeyController.text =
                            "<KEY>";

                        ppConfigController.text =
                            "{\"slug\":\"masira-darvesh-gile\"}";

                        feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = feeHeaderController.text;
                        Get.back();
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
                        "<KEY>";
                        clientIDController.text =
                            "<KEY>";

                        secretKeyController.text =
                            "<KEY>";

                        apiKeyController.text =
                            "<KEY>";

                        // ppConfigController.text = "{\"slug\":\"masira-d\"}";

                        // feeHeaderController.text =
                        //     "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        // feeHeader = feeHeaderController.text;
                        Get.back();
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
                        clientIDController.text =
                            "<KEY>";

                        secretKeyController.text =
                            "<KEY>";

                        apiKeyController.text =
                            "<KEY>";

                        ppConfigController.text =
                            "{\"slug\":\"masira-darvesh-ayc-two\"}";

                        feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = feeHeaderController.text;
                        Get.back();
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
                        clientIDController.text =
                            "<KEY>";

                        secretKeyController.text =
                            "<KEY>";

                        apiKeyController.text =
                            "<KEY>";

                        ppConfigController.text =
                            "{\"slug\":\"masira-darvesh-chinchwad\"}";

                        feeHeaderController.text =
                            "{\"Payable_fee_EMI\":15000, \"Payable_fee_Auto_Debit\":1000, \"Payable_fee_PG\":100}";
                        feeHeader = feeHeaderController.text;
                        Get.back();
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
        context: Get.context!, builder: (BuildContext context) => errorDialog);
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

  Map<String, dynamic>? getConfig() {
    try {
      Map<String, dynamic> auth = {
        "client_id": clientIDController.text,
        "client_secret_key": secretKeyController.text,
        "gq_api_key": apiKeyController.text
      };

      Map<String, dynamic> configObj = {
        "auth": auth,
        "student_id": studentIDController.text,
        if (customerNumberController.text.isNotEmpty)
          "customer_number": customerNumberController.text,
        "env": environment.value,
      };

      if (ppConfigController.text.isNotEmpty) {
        configObj["pp_config"] = jsonDecode(ppConfigController.text);
      }

      if (feeHeaderController.text.isNotEmpty) {
        configObj["fee_headers"] = json.decode(feeHeaderController.text);
      }

      if (referenceIdController.text.isNotEmpty) {
        configObj["reference_id"] = referenceIdController.text;
      }

      return configObj;
    } catch (e) {
      print('Error decoding JSON: $e');
    }

    return null;
  }

  handleSuccess(value) {
    data.value = value;
    print("PSuccess: $value ");
  }

  handleFailure(value) {
    data.value = value;
    print("PFailed: $value ");
  }

  handleCancel(value) {
    data.value = value;
    print("PCancel: $value ");
  }

  @override
  void onClose() {
    studentIDController.dispose();
    clientIDController.dispose();
    apiKeyController.dispose();
    environmentController.dispose();
    customerNumberController.dispose();
    ppConfigController.dispose();
    feeHeaderController.dispose();
    prefillObjController.dispose();
    secretKeyController.dispose();

    super.onClose();
  }
}
