class Papel {
  final int id;
  final String descricao;

  Papel({required this.id, required this.descricao});

  Map<String, dynamic> toJson() {
    return {'id': id, 'descricao': descricao};
  }

  factory Papel.fromJson(Map<String, dynamic> json) {
    return Papel(id: json['id'], descricao: json['descricao']);
  }
}
