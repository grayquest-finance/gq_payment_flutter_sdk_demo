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
  final TextEditingController emiPlanIdController = TextEditingController();
  final TextEditingController udfDetailsController = TextEditingController();
  final TextEditingController customisationController = TextEditingController();
  final TextEditingController paymentMethodController = TextEditingController();
  final TextEditingController feeHeaderSplitController =
      TextEditingController();
  final TextEditingController token = TextEditingController();

  RxString environment = ''.obs;
  String customerNumber = '';
  Map<String, dynamic> prefill = {};
  String feeHeader = '';
  String prefillObj = '';
  final RxString data = "".obs;
  final List list = [];

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
      if (emiPlanIdController.text.isNotEmpty) {
        configObj["emi_plan_id"] = emiPlanIdController.text;
      }

      if (udfDetailsController.text.isNotEmpty) {
        configObj["udf_details"] = jsonDecode(udfDetailsController.text);
      }

      if (customisationController.text.isNotEmpty) {
        configObj["customization"] = jsonDecode(customisationController.text);
      }

      if (paymentMethodController.text.isNotEmpty) {
        configObj["payment_methods"] = jsonDecode(paymentMethodController.text);
      }
      if (feeHeaderSplitController.text.isNotEmpty) {
        configObj["fee_headers_split"] =
            jsonDecode(feeHeaderSplitController.text);
      }
      return configObj;
    } catch (e) {
      print('Error decoding JSON: $e');
    }

    return null;
  }

  handleSuccess(value) {
    data.value = value;

    list.add(value);
    print("PSuccess: $value ");
  }

  handleFailure(value) {
    data.value = value;
    print("PFailed: $value ");
    list.add(value);
  }

  handleCancel(value) {
    data.value = value;
    print("PCancel: $value ");
    list.add(value);
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
    emiPlanIdController.dispose();
    udfDetailsController.dispose();
    customisationController.dispose();
    paymentMethodController.dispose();
    feeHeaderSplitController.dispose();
    super.onClose();
  }
}
