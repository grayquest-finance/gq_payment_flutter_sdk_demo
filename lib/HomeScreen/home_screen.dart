import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
                            value: 'stage',
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
                  controller: controller.customisationController,
                  decoration:
                      const InputDecoration(labelText: 'Customisation Object '),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.referenceIdController,
                  decoration: const InputDecoration(labelText: 'Reference ID'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.emiPlanIdController,
                  decoration: const InputDecoration(labelText: 'EMI Plan ID'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.udfDetailsController,
                  decoration: const InputDecoration(labelText: 'UDF Object '),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.paymentMethodController,
                  decoration: const InputDecoration(
                      labelText: 'payment methods (List)'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.feeHeaderSplitController,
                  decoration: const InputDecoration(
                      labelText: 'Fee headers split object '),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: controller.token,
                  decoration: const InputDecoration(labelText: 'Token'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const WebViewScreen(),
                    ));
                  },
                  child: const Text('Webview'),
                ),
                const SizedBox(height: 16),
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
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    controller.gqPaymentSDK.tokenCheckout(
                      context,
                      onCancel: controller.handleCancel,
                      onFailed: controller.handleFailure,
                      onSuccess: controller.handleSuccess,
                      env: controller.environment.value,
                      token: controller.token.text,
                    );
                  },
                  child: const Text('Open GQ SDK with Token'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 2),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Callback Messages',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        content: SizedBox(
                          width: double.maxFinite,
                          height: 300,
                          child: Column(
                            children: [
                              const Divider(thickness: 1),
                              Expanded(
                                child: ListView.separated(
                                  itemCount: controller.list.isEmpty
                                      ? 1
                                      : controller.list.length,
                                  separatorBuilder: (context, index) =>
                                      const Divider(height: 1),
                                  itemBuilder: (context, index) => controller
                                          .list.isEmpty
                                      ? const Center(
                                          child: Text("No message to show"))
                                      : ListTile(
                                          leading: Text((index + 1).toString()),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 4),
                                          title: Text(
                                            controller.list[index],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          visualDensity: VisualDensity.compact,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          ),
                        ],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    );
                  },
                  child: const Text('See Callback Messages',
                      style: TextStyle(fontSize: 16)),
                ),
                // const SizedBox(height: 20),
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

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'ENTER URL'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Webviews(
                      url: controller.text,
                    ),
                  ));
                },
                child: const Text("Open Webview"))
          ],
        ),
      ),
    );
  }
}

class Webviews extends StatefulWidget {
  final String url;
  const Webviews({super.key, required this.url});

  @override
  State<Webviews> createState() => _WebviewsState();
}

class _WebviewsState extends State<Webviews> {
  @override
  void initState() {
    super.initState();
    PlatformInAppWebViewController.debugLoggingSettings.enabled = true;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InAppWebView(
        initialSettings: InAppWebViewSettings(
          isInspectable: true,
          javaScriptCanOpenWindowsAutomatically: true,
          javaScriptEnabled: true,
          supportMultipleWindows: true,
          allowFileAccess: true,
          allowFileAccessFromFileURLs: true,
          allowContentAccess: true,
        ),
        initialUrlRequest: URLRequest(url: WebUri(widget.url)),
        onLoadStop: (controller, url) {
          setState(() {});
        },
        onCreateWindow: (controller, createWindowAction) async {
          // create a headless WebView using the createWindowAction.windowId to get the correct URL
          HeadlessInAppWebView? headlessWebView;
          headlessWebView = HeadlessInAppWebView(
            windowId: createWindowAction.windowId,
            onLoadStart: (controller, url) async {
              // print("URL inside Create Window: $url");
              if (url != null) {
                InAppBrowser.openWithSystemBrowser(
                    url: url); // to open with the system browser
                // or use the https://pub.dev/packages/url_launcher plugin
              }
              // dispose it immediately
              await headlessWebView?.dispose();
              headlessWebView = null;
            },
          );
          headlessWebView?.run();

          // return true to tell that we are handling the new window creation action
          return true;
        },
        onUpdateVisitedHistory: (controller, url, isReload) {
          print("UPDATED URLS: $url");
        },
        onCloseWindow: (controller) {
          print("window closing");
        },
        shouldOverrideUrlLoading: (controller, navigationAction) async {
          print("NAvigationsURL: ${navigationAction.request.url}");

          final Set<String> schemes = {'http', 'https', 'about'};
          // final hasValidScheme =
          //     Environment.checkUrlScheme(navigationAction.request.url?.scheme);

          if (!schemes.contains(navigationAction.request.url?.scheme)) {
            try {
              InAppBrowser.openWithSystemBrowser(
                  url: navigationAction.request.url!);
              return NavigationActionPolicy.CANCEL;
            } catch (e) {
              // print('Error launching UPI app: $e');
            }
          }
          return NavigationActionPolicy.ALLOW;
        },
      ),
    );
  }
}
