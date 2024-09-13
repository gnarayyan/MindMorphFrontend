import 'package:form_validator/form_validator.dart';

final longTextValidator =
    ValidationBuilder(requiredMessage: 'Field is required')
        .maxLength(1000)
        .minLength(10)
        .required()
        .build();
