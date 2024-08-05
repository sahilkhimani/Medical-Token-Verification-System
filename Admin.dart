import 'dart:io';
import 'data.dart';

List relationsList = [];

class Admin {
  adminFunction() {
    bool isTrue = true;
    while (isTrue) {
      print("\n-----Admin Panel-----\n");
      print("Press 1 to Add new Employee");
      print("Press 2 to Delete Employee");
      print("Press 3 to Exit\n");

      stdout.write("Choose Option: ");
      String userInput = stdin.readLineSync()!;

      switch (userInput) {
        case '1':
          addEmployee();
          break;
        case '2':
          deleteEmployee();
          break;
        case '3':
          isTrue = false;
          break;
        default:
          print("Plese choose the correct option");
      }
    }
  }
}

addEmployee() {
  print("----- Add Employee -----\n");
  bool isTrue = true;

  String? cnic;
  String? name;
  String? company;
  String? paymentMonth;
  String? paymentYear;

  List<Map>? family = [];

  while (isTrue) {
    print("Enter the cnic number of the employee or Press 0 to exit");
    try {
      int cnicNo = int.parse(stdin.readLineSync()!);
      if (cnicNo.toString().length == 13 || cnicNo == 0) {
        bool isCnic = true;
        cnic = cnicNo.toString();
        if (checkCnic(cnic)) {
          print("CNIC already exists");
          isCnic = false;
        }
        if (isCnic) {
          isTrue = false;
        }
      } else {
        print("CNIC number is not valid\n");
      }
    } catch (e) {
      print("CNIC number must be in numbers\n");
    }
  }
  if (cnic != '0') {
    name = getInput("Enter the name of Employee: ");

    company = getInput("Enter the name of the company: ");

    paymentMonth = getInput("Enter the Payment month: ");

    bool isPaymentYear = true;
    while (isPaymentYear) {
      stdout.write("Enter the Payment Year: ");
      try {
        int payment = int.parse(stdin.readLineSync()!);
        paymentYear = payment.toString();
        isPaymentYear = false;
      } catch (e) {
        print("Payment year must be in numbers");
      }
    }
    bool isFamily = true;
    while (isFamily) {
      print("\nDo You have Family Members ?");
      print("Press y to yes or Perss n to no");
      stdout.write("Enter: ");
      String choice = stdin.readLineSync()!.toLowerCase();
      if (choice == 'y') {
        family.add(addFamilyInfo(cnic ?? "Not found"));
      } else if (choice == 'n') {
        isFamily = false;
      } else {
        print("Please choose correct option");
      }
    }
  }
  Map<String, dynamic> employee = {
    "name": name,
    "company": company,
    "cnic": cnic,
    "paymentMonth": paymentMonth,
    "paymentYear": paymentYear,
    "family": family
  };

  employeeList.addAll({cnic!: employee});

//   File('Employee.dart').openWrite(mode: FileMode.append).write(employeeData);

  print(employeeList);
}

Map addFamilyInfo(String empCnic) {
  Map family = {};
  String? cnic;
  String? relation;

  String? name = getInput("Enter the name of member: ");

  bool isCnic = true;
  while (isCnic) {
    bool cnicExists = true;
    print("Enter the cnic number of the member");
    try {
      int cnicNo = int.parse(stdin.readLineSync()!);
      cnic = cnicNo.toString();
      if (cnic.length == 13) {
        if (checkCnic(cnic) || empCnic == cnic) {
          print("CNIC already exists");
          cnicExists = false;
        }
      } else {
        print("CNIC is not valid");
        cnicExists = false;
      }
      if (cnicExists) {
        isCnic = false;
      }
    } catch (e) {
      print("Cnic number must be in numbers");
    }
  }
  bool isRelation = true;
  while (isRelation) {
    print("Enter the relation with employee");
    relation = stdin.readLineSync()!.toLowerCase();
    if (relation == "wife" ||
        relation == "mother" ||
        relation == "father" ||
        relation == "daughter" ||
        relation == "son") {
      if (relationsList.contains(relation)) {
        print("$relation details already exists");
      } else {
        relationsList.add(relation);
        isRelation = false;
      }
    } else {
      print("Please Enter the correct relation");
    }
  }

  family.addAll({"name": name, "cnic": cnic, "relation": relation});

  return family;
}

String? getInput(String prompt) {
  String? input;
  do {
    stdout.write(prompt);
    input = stdin.readLineSync()!.toUpperCase();
  } while (input.isEmpty);
  return input;
}

bool checkCnic(String inputCnic) {
  bool isCnicExists = false;
  List<String> tempCnic = [];
  for (int i = 0; i < employeeList.length; i++) {
    employeeList.forEach((key, value) {
      tempCnic.add(key);
      tempCnic.add(employeeList[key]['family'][i]['cnic']);
    });
    tempCnic.forEach((element) {
      if (inputCnic == element) {
        isCnicExists = true;
      }
    });
  }
  return isCnicExists;
}

deleteEmployee() {
  String? cnic;
  stdout.write("Enter the cnic number to delete the record: ");
  try {
    int cnicNo = int.parse(stdin.readLineSync()!);
    cnic = cnicNo.toString();
    if (cnic.length == 13) {
      if (employeeList.containsKey(cnic)) {
        employeeList.removeWhere((key, value) => key == cnic);
        print("\nRecord Deleted");
      } else {
        print("No record against provided cnic number");
      }
    } else {
      print("CNIC number is not valid");
    }
  } catch (e) {
    print("CNIC number must be in numbers");
  }
}
