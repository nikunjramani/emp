class Employee {
  int id;
  String email;
  String socialInsuranceNumber;
  String dateOfBirth;
  String dateOfHire;
  String employeeName;
  String hireDate;
  String startDate;
  String employeeContactForm;
  String employeeCourseName;
  String employeeCourseDate;
  String employeeCertificateOfCourse;
  String diciplinaryActionNote;
  String diciplinaryForm;
  String assetOnHand;

  Employee(
      {this.id,
      this.email,
      this.socialInsuranceNumber,
      this.dateOfBirth,
      this.dateOfHire,
      this.employeeName,
      this.hireDate,
      this.startDate,
      this.employeeContactForm,
      this.employeeCourseName,
      this.employeeCourseDate,
      this.employeeCertificateOfCourse,
      this.diciplinaryActionNote,
      this.diciplinaryForm,
      this.assetOnHand});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    socialInsuranceNumber = json['social_insurance_number'];
    dateOfBirth = json['date_of_birth'];
    dateOfHire = json['date_of_hire'];
    employeeName = json['employee_name'];
    hireDate = json['hire_date'];
    startDate = json['start_date'];
    employeeContactForm = json['employee_contact_form'];
    employeeCourseName = json['employee_course_name'];
    employeeCourseDate = json['employee_course_date'];
    employeeCertificateOfCourse = json['employee_certificate_of_course'];
    diciplinaryActionNote = json['diciplinary_action_note'];
    diciplinaryForm = json['diciplinary_form'];
    assetOnHand = json['asset_on_hand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['social_insurance_number'] = this.socialInsuranceNumber;
    data['date_of_birth'] = this.dateOfBirth;
    data['date_of_hire'] = this.dateOfHire;
    data['employee_name'] = this.employeeName;
    data['hire_date'] = this.hireDate;
    data['start_date'] = this.startDate;
    data['employee_contact_form'] = this.employeeContactForm;
    data['employee_course_name'] = this.employeeCourseName;
    data['employee_course_date'] = this.employeeCourseDate;
    data['employee_certificate_of_course'] = this.employeeCertificateOfCourse;
    data['diciplinary_action_note'] = this.diciplinaryActionNote;
    data['diciplinary_form'] = this.diciplinaryForm;
    data['asset_on_hand'] = this.assetOnHand;
    return data;
  }
}
