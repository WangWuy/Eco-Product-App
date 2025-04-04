class DiscModel {
  final int id;
  final String name;
  final String image;
  final String offText;
  final String desc;

  DiscModel({
    required this.id,
    required this.name, 
    required this.image,
    required this.offText,
    required this.desc,
  });

  factory DiscModel.fromJson(Map<String, dynamic> json) {
    return DiscModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      offText: json['offText'],
      desc: json['desc'],
    );
  }
}