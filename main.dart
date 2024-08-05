import 'dart:io';
import 'User.dart';
import 'admin.dart';

void main() {
  bool isTrue = true;

  while (isTrue) {
    print("\n******** Employee Medical Verification System *********\n");
    print("Press 1 to login as Admin");
    print("Press 2 to login as User");
    print("Press 3 to close Program\n");
    stdout.write("Choose Option: ");

    String userInput = stdin.readLineSync()!;

    switch (userInput) {
      case '1':
        if (loginUser("admin@gmail.com", "sahil123")) {
          Admin ad = Admin();
          ad.adminFunction();
        } else {
          print("\nWrong email or password");
        }
        break;
      case '2':
        if (loginUser("user@gmail.com", "sahil123")) {
          User us = User();
          us.userFunction();
        } else {
          print("\nWrong email or password");
        }
        break;
      case '3':
        isTrue = false;
        break;
      default:
        print("\nPlease choose the correct option");
        break;
    }
  }
}

bool loginUser(String email, String Password) {
  bool isLogin = false;
  stdout.write("Enter the email address: ");
  String userEmail = stdin.readLineSync()!;

  stdout.write("Enter the password: ");
  String userPass = stdin.readLineSync()!;

  if (email == userEmail && Password == userPass) {
    isLogin = true;
  }
  return isLogin;
}
