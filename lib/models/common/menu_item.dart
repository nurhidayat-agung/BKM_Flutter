class MenuItem {
  int? sort;
  String? menuName;
  String? icon;
  bool? show;

  MenuItem({this.sort, this.menuName, this.icon, this.show = true});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      sort: json['sort'] is int
          ? json['sort']
          : int.tryParse(json['sort']?.toString() ?? ''),
      menuName: json['menu_name'],
      icon: json['icon'],
      show: json['show'] == null
          ? true
          : (json['show'] == true ||
              json['show'] == 1 ||
              json['show'].toString().toLowerCase() == 'true'),
    );
  }

  Map<String, dynamic> toJson() => {
    'sort': sort,
    'menu_name': menuName,
    'icon': icon,
    'show': show,
  };
}
