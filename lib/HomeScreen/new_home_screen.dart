import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/Controller/home_screen_controller.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/webview_url_utils.dart';
import 'package:gq_payment_flutter_sdk_demo/HomeScreen/webviews.dart';
import 'package:gq_payment_flutter_sdk_demo/theme/app_colors.dart';

const _accent = kAccentColor;
const _dark = kDarkColor;
const _bg = kBgColor;
const _border = kBorderColor;
const _labelColor = kLabelColor;
const _mono = kMonoTextStyle;

class NewHomeScreen extends GetView<HomeScreenController> {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _dark,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: _accent.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: _accent.withValues(alpha: 0.6)),
              ),
              child: const Text(
                'GQ',
                style: TextStyle(
                  color: _accent,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Payment Demo App',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.3,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => _showCallbacks(context),
            child: const Text(
              'Callbacks',
              style: TextStyle(color: Colors.white60, fontSize: 13),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _SectionCard(
            title: 'Authentication',
            icon: Icons.lock_outline_rounded,
            children: [
              _MonoField(
                controller: controller.clientIDController,
                label: 'Client ID',
                hint: 'GQ-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                required: true,
              ),
              const SizedBox(height: 12),
              _MonoField(
                controller: controller.secretKeyController,
                label: 'Client Secret Key',
                hint: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                required: true,
                obscure: true,
              ),
              const SizedBox(height: 12),
              _MonoField(
                controller: controller.apiKeyController,
                label: 'GQ API Key',
                hint: 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
                required: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: 'Environment',
            icon: Icons.dns_outlined,
            children: [
              Obx(() => Row(
                    children: [
                      _EnvChip(
                        label: 'UAT',
                        value: 'test',
                        selected: controller.environment.value == 'test',
                        onTap: () => controller.environment.value = 'test',
                      ),
                      const SizedBox(width: 8),
                      _EnvChip(
                        label: 'Stage',
                        value: 'stage',
                        selected: controller.environment.value == 'stage',
                        onTap: () => controller.environment.value = 'stage',
                      ),
                      const SizedBox(width: 8),
                      _EnvChip(
                        label: 'Pre-Prod',
                        value: 'preprod',
                        selected: controller.environment.value == 'preprod',
                        onTap: () => controller.environment.value = 'preprod',
                      ),
                      const SizedBox(width: 8),
                      _EnvChip(
                        label: 'Live',
                        value: 'live',
                        selected: controller.environment.value == 'live',
                        onTap: () => controller.environment.value = 'live',
                        liveEnv: true,
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: 'Order Details',
            icon: Icons.receipt_long_outlined,
            children: [
              _InputField(
                controller: controller.studentIDController,
                label: 'Student ID',
                required: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.customerNumberController,
                label: 'Customer Mobile',
                hint: '10-digit number',
                keyboardType: TextInputType.phone,
                maxLength: 10,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.referenceIdController,
                label: 'Reference ID',
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.emiPlanIdController,
                label: 'EMI Plan ID',
              ),
            ],
          ),
          const SizedBox(height: 10),
          _ExpandableSection(
            title: 'Advanced Config',
            icon: Icons.tune_outlined,
            children: [
              _InputField(
                controller: controller.ppConfigController,
                label: 'Payment Pages Config',
                hint: '{ "slug": "..." }',
                mono: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.feeHeaderController,
                label: 'Fee Headers',
                hint: '{ "Payable_fee_EMI": 15000 }',
                mono: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.prefillObjController,
                label: 'Prefill Object',
                hint: '{ }',
                mono: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.customisationController,
                label: 'Customisation Object',
                hint: '{ "theme_color": "6C5CE7" }',
                mono: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.paymentMethodController,
                label: 'Payment Methods',
                hint: '[ "upi", "card" ]',
                mono: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.feeHeaderSplitController,
                label: 'Fee Headers Split',
                hint: '{ }',
                mono: true,
              ),
              const SizedBox(height: 12),
              _InputField(
                controller: controller.udfDetailsController,
                label: 'UDF Object',
                hint: '{ }',
                mono: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: 'Token Checkout',
            icon: Icons.token_outlined,
            children: [
              _MonoField(
                controller: controller.token,
                label: 'JWT Token',
                hint: 'eyJ...',
              ),
            ],
          ),
          const SizedBox(height: 10),
          _SectionCard(
            title: 'WebView',
            icon: Icons.public_outlined,
            children: [
              _InputField(
                controller: controller.webviewUrlController,
                label: 'URL',
                hint: 'https://example.com',
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: _OutlineButton(
                  label: 'Open in WebView',
                  icon: Icons.open_in_browser_outlined,
                  onPressed: () => _openWebview(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _PrimaryButton(
                    label: 'Open GQ SDK',
                    icon: Icons.play_arrow_rounded,
                    onPressed: () {}),
              ),
              const SizedBox(width: 10),
              _OutlineButton(
                label: 'Token',
                icon: Icons.token_outlined,
                onPressed: () => _tokenCheckout(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() => controller.data.value.isEmpty
              ? const SizedBox.shrink()
              : _CallbackBanner(message: controller.data.value)),
        ],
      ),
    );
  }

  void _openSDK(BuildContext context) {
    final config = controller.getConfig();
    if (config == null) {
      _showSnack(context, 'Check required fields and JSON values');
      return;
    }
    controller.gqPaymentSDK.checkout(
      context,
      configData: jsonEncode(config),
      onSuccess: controller.handleSuccess,
      onFailed: controller.handleFailure,
      onCancel: controller.handleCancel,
    );
  }

  void _tokenCheckout(BuildContext context) {
    final token = controller.token.text.trim();
    final env = controller.environment.value;
    if (token.isEmpty) {
      _showSnack(context, 'Enter a JWT token in the Token Checkout section');
      return;
    }
    if (env.isEmpty) {
      _showSnack(context, 'Select an environment');
      return;
    }
    controller.gqPaymentSDK.tokenCheckout(
      context,
      env: env,
      token: token,
      onSuccess: controller.handleSuccess,
      onFailed: controller.handleFailure,
      onCancel: controller.handleCancel,
    );
  }

  void _openWebview(BuildContext context) {
    final raw = controller.webviewUrlController.text.trim();
    if (raw.isEmpty) {
      _showSnack(context, 'Enter a URL to open in the WebView');
      return;
    }
    final url = normalizeWebviewUrl(raw);
    if (url == null) {
      _showSnack(context, 'Enter a valid http/https URL');
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Webviews(url: url)),
    );
  }

  void _showSnack(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ));
  }

  void _showCallbacks(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
        title: const Text(
          'Callback Messages',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            letterSpacing: -0.2,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          height: 320,
          child: controller.list.isEmpty
              ? const Center(
                  child: Text(
                    'No callbacks yet',
                    style: TextStyle(color: _labelColor, fontSize: 14),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  itemCount: controller.list.length,
                  separatorBuilder: (_, __) =>
                      const Divider(height: 1, indent: 20, endIndent: 20),
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${i + 1}',
                          style: const TextStyle(
                            color: _labelColor,
                            fontSize: 11,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            controller.list[i].toString(),
                            style: _mono.copyWith(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

// ─── Section card ──────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 11, 14, 9),
            child: Row(children: [
              Icon(icon, size: 14, color: _accent),
              const SizedBox(width: 6),
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.9,
                  color: _labelColor,
                ),
              ),
            ]),
          ),
          const Divider(height: 1, color: Color(0xFFEEEEF4)),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Expandable section ────────────────────────────────────────────────────────

class _ExpandableSection extends StatefulWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _ExpandableSection({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  State<_ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<_ExpandableSection> {
  bool _open = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _border),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _open = !_open),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 11, 14, 11),
              child: Row(children: [
                Icon(widget.icon, size: 14, color: _accent),
                const SizedBox(width: 6),
                Text(
                  widget.title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.9,
                    color: _labelColor,
                  ),
                ),
                const Spacer(),
                AnimatedRotation(
                  turns: _open ? 0.5 : 0,
                  duration: const Duration(milliseconds: 180),
                  child: const Icon(Icons.keyboard_arrow_down_rounded,
                      size: 18, color: _labelColor),
                ),
              ]),
            ),
          ),
          if (_open) ...[
            const Divider(height: 1, color: Color(0xFFEEEEF4)),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(children: widget.children),
            ),
          ],
        ],
      ),
    );
  }
}

// ─── Environment chip ──────────────────────────────────────────────────────────

class _EnvChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final bool liveEnv;
  final VoidCallback onTap;

  const _EnvChip({
    required this.label,
    required this.value,
    required this.selected,
    required this.onTap,
    this.liveEnv = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = liveEnv ? const Color(0xFFE53935) : _accent;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 140),
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: selected ? color.withValues(alpha: 0.09) : _bg,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: selected ? color : _border,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? color : _labelColor,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Input fields ──────────────────────────────────────────────────────────────

InputDecoration _fieldDecoration(String label,
    {String? hint, bool required = false, Widget? suffix}) {
  return InputDecoration(
    labelText: required ? '$label *' : label,
    hintText: hint,
    hintStyle: const TextStyle(
      fontFamily: 'monospace',
      fontSize: 11,
      color: Color(0xFFCCCCDD),
    ),
    labelStyle: const TextStyle(fontSize: 13, color: _labelColor),
    floatingLabelStyle: const TextStyle(fontSize: 12, color: _accent),
    isDense: true,
    counterText: '',
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _border),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _border),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: _accent, width: 1.5),
    ),
    suffixIcon: suffix,
  );
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool required;
  final bool mono;
  final TextInputType? keyboardType;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const _InputField({
    required this.controller,
    required this.label,
    this.hint,
    this.required = false,
    this.mono = false,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      style: mono ? _mono : const TextStyle(fontSize: 14),
      decoration: _fieldDecoration(label, hint: hint, required: required),
    );
  }
}

class _MonoField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hint;
  final bool required;
  final bool obscure;

  const _MonoField({
    required this.controller,
    required this.label,
    this.hint,
    this.required = false,
    this.obscure = false,
  });

  @override
  State<_MonoField> createState() => _MonoFieldState();
}

class _MonoFieldState extends State<_MonoField> {
  late bool _hidden;

  @override
  void initState() {
    super.initState();
    _hidden = widget.obscure;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _hidden,
      style: _mono,
      decoration: _fieldDecoration(
        widget.label,
        hint: widget.hint,
        required: widget.required,
        suffix: widget.obscure
            ? IconButton(
                icon: Icon(
                  _hidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: _labelColor,
                ),
                onPressed: () => setState(() => _hidden = !_hidden),
              )
            : null,
      ),
    );
  }
}

// ─── Buttons ───────────────────────────────────────────────────────────────────

class _PrimaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 19),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: _dark,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _OutlineButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 17),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          foregroundColor: _accent,
          side: const BorderSide(color: _accent),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

// ─── Last callback banner ──────────────────────────────────────────────────────

class _CallbackBanner extends StatelessWidget {
  final String message;

  const _CallbackBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _dark.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _dark.withValues(alpha: 0.08)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, size: 15, color: _accent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style:
                  _mono.copyWith(fontSize: 12, color: const Color(0xFF4A4A6A)),
            ),
          ),
        ],
      ),
    );
  }
}
