bool isEmailValid(String email) =>
    email.isNotEmpty &&
    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
