import 'package:form_validator/form_validator.dart';

final datetimeValidator =
    ValidationBuilder(requiredMessage: 'Field is required').required().build();
