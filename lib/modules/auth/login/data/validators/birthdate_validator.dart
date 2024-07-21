import 'package:form_validator/form_validator.dart';

const minAge = 10;
const maxAge = 85;

final dobValidator = ValidationBuilder(requiredMessage: 'Birthdate is required')
    .add(ensureDateRange)
    .regExp(RegExp(r'^\d{4}-\d{2}-\d{2}$'), 'Invalid date format')
    .required()
    .build();

String? ensureDateRange(String? value) {
  if (value == null || value.isEmpty) {
    return 'Birthdate cannot be empty';
  }

  // // Try to parse the value as an integer
  // final double? number = double.tryParse(value);
  // if (number == null) {
  //   return 'Price must be a valid number';
  // }
  // // Check if the number is within the range 10 to 999
  // if (number < minPrice || maxPrice > 999) {
  //   return 'Price must be between $minPrice and $maxPrice';
  // }

  return null; // The input is valid
}
