import 'package:userpapeis/model/papel_model.dart';

class Usuario {
  final int id;
  final String nome;
  final List<Papel> papeis;
  final DateTime? dataCadastro;

  Usuario({
    required this.id,
    required this.nome,
    required this.papeis,
    this.dataCadastro,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'papeis': papeis.map((papel) => papel.toJson()).toList(),
      'dataCadastro': dataCadastro?.toIso8601String(),
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonPapeis = json['papeis'];
    final List<Papel> papeis = jsonPapeis.map((jsonPapel) {
      return Papel.fromJson(jsonPapel);
    }).toList();

    return Usuario(
      id: json['id'],
      nome: json['nome'],
      papeis: papeis,
      dataCadastro: json['dataCadastro'] != null
          ? DateTime.parse(json['dataCadastro'])
          : null,
    );
  }
}
