class RegNoValidator {
  static String? validate(String value) {
    // The regular expression pattern for the registration number
    // You can modify this pattern according to your specific requirements
    final pattern = r'^[A-Z]{2}\d{2}[A-Z]{2}\d{4}$';

    if (value.isEmpty) {
      return 'Registration number is required';
    }

    if (!RegExp(pattern).hasMatch(value)) {
      return 'Invalid registration number';
    }

    return null; // Return null if the value is valid
  }
}