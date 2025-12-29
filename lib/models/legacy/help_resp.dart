class HelpResp {
  String? id;
  String? title;
  String? helpCode;
  String? value;
  String? updatedBy;
  String? updatedDate;
  String? createdBy;
  String? createdDate;
  String? isactive;

  HelpResp(
      {this.id,
        this.title,
        this.helpCode,
        this.value,
        this.updatedBy,
        this.updatedDate,
        this.createdBy,
        this.createdDate,
        this.isactive});

  HelpResp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    helpCode = json['help_code'];
    value = json['value'];
    updatedBy = json['updated_by'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    createdDate = json['created_date'];
    isactive = json['isactive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['help_code'] = this.helpCode;
    data['value'] = this.value;
    data['updated_by'] = this.updatedBy;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['created_date'] = this.createdDate;
    data['isactive'] = this.isactive;
    return data;
  }
}