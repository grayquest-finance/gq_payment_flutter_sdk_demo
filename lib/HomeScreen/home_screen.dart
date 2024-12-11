import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/Controller/home_screen_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("GrayQuest Payment Flutter SDK"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextField(
                  controller: controller.clientIDController,
                  decoration: const InputDecoration(labelText: 'Client ID *'),
                ),
                const SizedBox(height: 20),
                TextField(
                    controller: controller.secretKeyController,
                    decoration: const InputDecoration(
                        labelText: 'Client Secret Key *')),
                const SizedBox(height: 20),
                TextField(
                    controller: controller.apiKeyController,
                    decoration:
                        const InputDecoration(labelText: 'GQ API Key *')),
                const SizedBox(height: 16.0),
                const Text(
                  'Select Environment *',
                  textAlign: TextAlign.left,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Obx(() => RadioListTile(
                            value: 'test',
                            groupValue: controller.environment.value,
                            onChanged: (value) {
                              controller.environment.value = value!;
                            },
                            title: const Text('UAT'),
                          )),
                    ),
                    Expanded(
                      child: Obx(() => RadioListTile(
                            value: 'staging',
                            groupValue: controller.environment.value,
                            onChanged: (value) {
                              controller.environment.value = value!;
                            },
                            title: const Text('Stage'),
                          )),
                    ),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Obx(() => RadioListTile(
                              value: 'preprod',
                              groupValue: controller.environment.value,
                              onChanged: (value) {
                                controller.environment.value = value!;
                              },
                              title: const Text('Pre-Prod'),
                            )),
                      ),
                      Expanded(
                        child: Obx(() => RadioListTile(
                              value: 'live',
                              groupValue: controller.environment.value,
                              onChanged: (value) {
                                controller.environment.value = value!;
                              },
                              title: const Text('Live'),
                            )),
                      ),
                    ]),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.studentIDController,
                  decoration: const InputDecoration(labelText: 'Student ID *'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.customerNumberController,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: const InputDecoration(
                      labelText: 'Customer Mobile Number'),
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.ppConfigController,
                  decoration: const InputDecoration(
                      labelText: 'Payment Pages Configuration'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.feeHeaderController,
                  decoration: const InputDecoration(labelText: 'Fee Headers'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.prefillObjController,
                  decoration:
                      const InputDecoration(labelText: 'Prefill Object'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.referenceIdController,
                  decoration: const InputDecoration(labelText: 'Reference ID'),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          controller.gqPaymentSDK.checkout(context,
                              onCancel: controller.handleCancel,
                              onFailed: controller.handleFailure,
                              onSuccess: controller.handleSuccess,
                              configData: jsonEncode(controller.getConfig()),
                              options: controller.prefillObjController.text);
                        },
                        child: const Text('Open GQ SDK'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 2),
                        onPressed: () {
                          controller.customDialog();
                        },
                        child: const Text('Prefill'),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                  ],
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(controller.data.value.toString()),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
