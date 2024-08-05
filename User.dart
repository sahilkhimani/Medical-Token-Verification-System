import 'dart:io';
import 'Data.dart';

DateTime now = DateTime.now();
int currentMonth = now.month;
int currentYear = now.year;

class User {
  userFunction() {
    print(employeeList);
    bool isTrue = true;
    while (isTrue) {
      print("\n-----Verify Employees Page-----\n");
      print("Press 1 to verify Employee details");
      print("Press 2 to Exit\n");
      stdout.write("Choose Option: ");
      String userInput = stdin.readLineSync()!;

      switch (userInput) {
        case '1':
          verifyEmployee();
          break;
        case '2':
          isTrue = false;
          break;
        default:
          print("Please choose correct option");
          break;
      }
    }
  }
}

verifyEmployee() {
  stdout.write("Enter Employee CNIC: ");
  String uniqueNumber = stdin.readLineSync()!;

  if (employeeList.containsKey(uniqueNumber)) {
    Map data = employeeList['$uniqueNumber'];
    if (checkPayment(data['paymentMonth'], data['paymentYear'])) {
      print("\nWhose checkup do you want to get done?\n");
      print("press l for Self");
      print("Press w for Wife");
      print("Press f for Father");
      print("Press m for Mother");
      print("Press d for daughter");
      print("Press s for son\n");

      stdout.write("Choose Option: ");
      String option = stdin.readLineSync()!;
      option = option.toLowerCase();

      switch (option) {
        case 'l':
          token(detail: data, opt: option);
          break;
        case 'w':
          String optionRelation = "WIFE";
          checkFamilyExists(optionRelation, data);
          break;
        case 'f':
          String optionRelation = "FATHER";
          checkFamilyExists(optionRelation, data);
          break;
        case 'm':
          String optionRelation = "MOTHER";
          checkFamilyExists(optionRelation, data);
          break;
        case 'd':
          String optionRelation = "DAUGHTER";
          checkFamilyExists(optionRelation, data);
          break;
        case 's':
          String optionRelation = "SON";
          checkFamilyExists(optionRelation, data);
          break;
        default:
          print("Please choose the correct option");
          break;
      }
    } else {
      print("Sorry! Payment is not paid");
    }
  } else {
    print("Employee Not found!");
  }
}

checkFamilyExists(String relateOption, Map data) {
  int index =
      data['family'].indexWhere((val) => val['relation'] == relateOption);
  if (index >= 0) {
    token(detail: data, index: index);
  } else {
    print("Sorry No Record Found For $relateOption");
  }
}

token({required Map detail, opt, index}) {
  if (opt == 'l') {
    String medicalSlip = '''
      -----------------------------------
              Medical Token
      -----------------------------------

      Patient Name   : ${detail["name"]}
      patient CNIC   : ${detail['cnic']}
      Company Name   : ${detail['company']}
      Payment        : ${detail['paymentMonth']} ${detail['paymentYear']}
      
      -----------------------------------
                    Verified
      -----------------------------------
      ''';
    print(medicalSlip);
  } else {
    String FamilyMedSlip = '''
      -----------------------------------
              Medical Token
      -----------------------------------

      Patient Name   : ${detail["family"][index]["name"]}
      patient CNIC   : ${detail['family'][index]["cnic"]}
      Employee Name  : ${detail["name"]}
      Employee CNIC  : ${detail["cnic"]}
      Relation       : ${detail["family"][index]["relation"]}
      Company Name   : ${detail['company']}
      Payment        : ${detail['paymentMonth']} ${detail['paymentYear']}

      -----------------------------------
                    Verified
      -----------------------------------
      ''';
    print(FamilyMedSlip);
  }
}

bool checkPayment(String mon, String year) {
  bool verifyMonth = false;
  mon = mon.toLowerCase();
  int saal = int.parse(year);
  List<String> monthNames = [
    'january',
    'february',
    'march',
    'april',
    'may',
    'june',
    'july',
    'august',
    'september',
    'october',
    'november',
    'december'
  ];

  int index = monthNames.indexOf(mon) + 1;
  num monthDiff = (currentYear - saal) * 12 + (currentMonth - index);
  if (monthDiff <= 3 && monthDiff >= 0) {
    verifyMonth = true;
  }
  return verifyMonth;
}
