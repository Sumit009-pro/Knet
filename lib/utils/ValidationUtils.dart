class ValidationUtils {
  static String isEmpty(String value, String fieldName) {
    if (value == null || value.isEmpty) {
      return "$fieldName is required";
    }
    return null;
  }

  static String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    if (value.length == 0) {
      return "Mobile is Required";
    } else if (value.length != 8) {
      return "Mobile number must 8 digits";
    }
    return null;
  }

  static String name(String value) {
    if (value.isEmpty) {
      return "Name is required";
    }
    return null;
  }

  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email is required";
    } else if (!regex.hasMatch(value.trim())) {
      return "Enter valid email";
    } else
      return null;
  }

  static bool validateEmailClicked(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return false;
    } else if (!regex.hasMatch(value.trim())) {
      return false;
    } else
      return true;
  }

  static String validateCharOnly(String value, String fieldName) {
    Pattern pattern = r'^[a-zA-Z]+$';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return "$fieldName is required";
    } else if (!regex.hasMatch(value.trim())) {
      return "Enter valid $fieldName";
    }
  }

  static bool isValidUrl(String value) {
    Pattern pattern = r"^(?:(ftp|http|https):\/\/)?(?:[\w-]+\.)+[a-z]{2,6}";
    RegExp regex = new RegExp(pattern);
    if (value == null) {
      return false;
    } else if (!regex.hasMatch(value.trim())) {
      return false;
    }
    return true;
  }
}
