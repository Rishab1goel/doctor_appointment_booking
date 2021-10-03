class Validator {
  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern);

    if (value == '' || value == null) {
      return 'E-mail is required';
    }
    if (!regex.hasMatch(value)) {
      return 'Invalid email address';
    }
  }

  static String? validatePhone(String? value) {
    String pattern =  r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regex = RegExp(pattern);

    if (value == '' || value == null) {
      return 'Phone number is required';
    }
    if (!regex.hasMatch(value)) {
      return 'Invalid phone number';
    }
  }

  static String? validatePassword(String? value) {
    if (value == '' || value == null) return 'Enter password';
    if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    }
  }

  static String? validateConfirmPassword(
      String? confirmPassword, String? password) {
    if (confirmPassword != password) {
      return 'Password not match';
    }
  }

  static String? validateName(String? value) {
    String pattern = r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$";
    RegExp regex = RegExp(pattern);

    if (value == '' || value == null) {
      return 'Name is required';
    }
    if (!regex.hasMatch(value)) {
      return 'Invalid name';
    }
  }
  

  // /^[a-z ,.'-]+$/i
}

