class Employees {
  String? employeeCode;
  String? firstName;
  String? lastName;

  Employees({this.employeeCode, this.firstName, this.lastName});

  factory Employees.fromJson(Map<String, dynamic> json) {
    return Employees(
      employeeCode: json['EmployeeCode'] ?? '',
      firstName: json['FirstName'],
      lastName: json['LastName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EmployeeCode': employeeCode,
      'FirstName': firstName,
      'LastName':lastName
    };
  }

  // Additional methods for creating and updating data if needed
}
