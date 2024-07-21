import 'package:form_validator/form_validator.dart';

final fullNameValidator =
    ValidationBuilder(requiredMessage: 'Full Name is required')
        .required()
        .regExp(RegExp(r'(?!.*(\S)\1\1)^\S+( \S+)+'), 'Invalid name format')
        .minLength(5)
        .maxLength(50)
        .build();
