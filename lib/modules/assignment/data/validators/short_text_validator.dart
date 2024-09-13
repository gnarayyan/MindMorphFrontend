import 'package:form_validator/form_validator.dart';

final shortTextValidator =
    ValidationBuilder(requiredMessage: 'Field is required')
        .maxLength(50)
        .minLength(10)
        .required()
        .build();
