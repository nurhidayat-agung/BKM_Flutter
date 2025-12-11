class MenuItem {
  int? sort;
  String? menuName;
  String? icon;

  MenuItem({this.sort, this.menuName, this.icon});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      sort: json['sort'],
      menuName: json['menu_name'],
      icon: json['icon'],
    );
  }

  Map<String, dynamic> toJson() => {
    'sort': sort,
    'menu_name': menuName,
    'icon': icon,
  };
}
