import 'package:form_validator/form_validator.dart';

final numberValidator = ValidationBuilder(requiredMessage: 'Field is required')
    .maxLength(4)
    .minLength(1)
    .required()
    .build();
