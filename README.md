# GQPaymentSDK Flutter

## Overview
The SDK is an integrated flow in ERP that will enable users to avail multiple payment options in a seamless manner, with faster integration and deployment times.

<!-- The `GQPaymentSDK` is a payment SDK that allows developers to integrate a seamless payment gateway into their Flutter applications. It provides callbacks for success, failure, and cancellation of the payment process, along with options for prefilled user data. -->


## Installation

Add the GQPaymentSDK to your `pubspec.yaml`:
```yaml
dependencies:
  gq_payment_sdk: ^latest_version
```
## Import it 
Now in your Dart code, you can use:
```dart
 import 'package:gq_payment_flutter_sdk/gq_payment_flutter_sdk.dart';
```

## Usage

### Initialization
Create an instance of the GQPaymentSDK:
```dart
final GQPaymentSDK gqPaymentSDK = GQPaymentSDK();
```

### Checkout Method
The checkout method allows you to process payments with comprehensive callback handling:


The `client_id`, `client_secret_key`, and `gq_api_key` are used to get the access to the payment, this will be shared from the GrayQuest.
GrayQuest provides two environments, one being the stage environment for developers to test the payment flow and responses and the other being live environment which gets shipped to production. This environment can be set in this client object.

```dart
final Map<String, dynamic> clientObject = {
   "auth": {
      "client_id": "<client_id>",
      "client_secret_key": "<client_secret_key>",
      "gq_api_key": " <gq_api_key>"
    },
    "env": " <env>",
    "student_id": "<student_id>",
    "customer_number": "<customer_number>",
    "pp_config": {"slug": "<slug>"},
    "customization": {
      "logo_url": "<logo_url>",
      "theme_color": "<theme_color>"
    },
    "fee_headers": {
      "fee_type_1": "<fee_type_1>",
      "fee_type_2": "<fee_type_2>",
      "fee_type_n": "<fee_type_n>",
    },
  };

  Map<String, dynamic> studentDetails = {
  "student_first_name": "<student_first_name>",
  "student_last_name": "<student_last_name>",
  "student_type": "<student_type>",
};

Map<String, dynamic> customerDetails = {
  "customer_first_name": "<customer_first_name>",
  "customer_last_name": "<customer_last_name>",
  "customer_dob": "<customer_dob>",
  "customer_gender": "<customer_gender>",
  "customer_email": "<customer_email>",
  "customer_marital_status": "<customer_marital_status>",
};

Map<String, dynamic> kycDetails = {
  "pan_number": "<pan_number>",
};

Map<String, dynamic> employmentDetails = {
  "income_type": "<income_type>",
  "employer_name": "<employer_name>",
  "work_experience": "<work_experience>",
  "net_monthly_salary": "<net_monthly_salary>",
  "business_name": "<business_name>",
  "business_turnover": "<business_turnover>",
  "business_annual_income": "<business_annual_income>",
  "business_category": "<business_category>",
  "business_type": "<business_type>",
  "business_description": "<business_description>",
  "business_employee_count": "<business_employee_count>",
  "years_of_current_business": "<years_of_current_business>",
  "same_as_residence_address": "<same_as_residence_address>",
  "addr_line_1": "<addr_line_1>",
  "addr_line_2": "<addr_line_2>",
  "city": "<city>",
  "state": "<state>",
};

Map<String, dynamic> customization = {
  "fee_helper_text": "<fee_helper_text>",
  "logo_url": "<logo_url>",
  "theme_color": "<theme_color>",
};

Map<String, dynamic> notes = {
  "key": "<value>",
};

Map<String, dynamic> prefillData = {
  "student_details": studentDetails,
  "customer_details": customerDetails,
  "kyc_details": kycDetails,
  "employment_details": employmentDetails,
  "customization": customization,
  "notes": notes,
};

  handleCancel(value) {
    print("OnCancelled: $value ");
  }

  handleFailure(value) {
    print("OnFailure: $value ");
  }

  handleSuccess(value) {
    print("OnSuccess: $value ");
  }

final jsonData = jsonEncode(clientObject);
final prefill = jsonEncode(prefillData);

gqPaymentSDK.checkout(
  context,
  onCancel: handleCancel,
  onFailed: handleFailure,
  onSuccess: handleSuccess,
  configData: jsonData,
  options: prefill
);


```

### Parameters

| Parameter | Type | Description | Required |
|-----------|------|-------------|----------|
| `context` | BuildContext | Current app context | Yes |
| `onCancel` | Function | Callback when payment is cancelled | Optional |
| `onFailed` | Function | Callback when payment fails | Optional |
| `onSuccess` | Function | Callback when payment succeeds | Optional |
| `jsonData` | String | Encoded configuration data | Yes |
| `options` | String | Encoded optional configuration data | Optional |

## Error Handling
The SDK provides three primary callback methods to manage different payment scenarios:
- `onSuccess`: Triggered on successful payment completion
- `onFailed`: Triggered when payment encounters an error
- `onCancel`: Triggered when user cancels the payment process

## Best Practices
1. Validate input before initiating checkout
2. Always handle all three callback scenarios

## Troubleshooting
- Ensure all required parameters are correctly configured
- Check network connectivity
- Review error logs for specific failure reasons

## License

GQPaymentIOSSDK is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Support
For additional support, contact GQPaymentSDK support team at support@grayquest.com
