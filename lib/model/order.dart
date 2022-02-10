class Order {
  bool success;
  List<Data> data;

  Order({this.success, this.data});

  Order.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data = null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String serviceTitle;
  String serviceSchedule;
  String manageOfWorkOrder;
  String assignedProvider;
  String serviceLocation;
  String orderId;
  String traningLink;
  String helpDeskContact;
  String managerOnDuty;
  String orientationKeyword;
  String status;
  List<CustomField> customField;

  Data(
      {this.id,
      this.serviceTitle,
      this.serviceSchedule,
      this.manageOfWorkOrder,
      this.assignedProvider,
      this.serviceLocation,
      this.orderId,
      this.traningLink,
      this.helpDeskContact,
      this.managerOnDuty,
      this.orientationKeyword,
      this.status,
      this.customField});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceTitle = json['service_title'];
    serviceSchedule = json['service_schedule'];
    manageOfWorkOrder = json['manage_of_work_order'];
    assignedProvider = json['assigned_provider'];
    serviceLocation = json['service_location'];
    orderId = json['order_id'];
    traningLink = json['traning_link'];
    helpDeskContact = json['help_desk_contact'];
    managerOnDuty = json['manager_on_duty'];
    orientationKeyword = json['orientation_keyword'];
    status = json['status'];
    if (json['custom_field'] != null) {
      customField = <CustomField>[];
      json['custom_field'].forEach((v) {
        customField.add(CustomField.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_title'] = this.serviceTitle;
    data['service_schedule'] = this.serviceSchedule;
    data['manage_of_work_order'] = this.manageOfWorkOrder;
    data['assigned_provider'] = this.assignedProvider;
    data['service_location'] = this.serviceLocation;
    data['order_id'] = this.orderId;
    data['traning_link'] = this.traningLink;
    data['help_desk_contact'] = this.helpDeskContact;
    data['manager_on_duty'] = this.managerOnDuty;
    data['orientation_keyword'] = this.orientationKeyword;
    data['status'] = this.status;
    if (this.customField = null) {
      data['custom_field'] = this.customField.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomField {
  int id;
  String title;
  String value;

  CustomField({this.id, this.title, this.value});

  CustomField.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}
