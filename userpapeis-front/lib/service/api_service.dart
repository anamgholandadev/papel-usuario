import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:userpapeis/model/papel_model.dart';
import 'package:userpapeis/model/usuario_model.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<List<Papel>> fetchPapeis() async {
    final response = await http.get(Uri.parse('$baseUrl/papeis'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => Papel.fromJson(item)).toList();
    } else {
      throw Exception('Falha ao buscar papeis');
    }
  }

  Future<void> cadastrarPapel(Papel papel) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/papeis'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(papel.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao cadastrar papel: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao cadastrar papel: $e');
    }
  }

  Future<void> deletePapel(int papelId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/papeis/$papelId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Falha ao excluir papel: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao excluir papel: $e');
    }
  }

  Future<void> editarPapel(int papelId, Papel novoPapel) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/papeis/$papelId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(novoPapel.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao editar papel: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao editar papel: $e');
    }
  }

  Future<void> deletarTodosPapeis() async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/papeis'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Falha ao excluir todos os papéis: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao excluir todos os papéis: $e');
    }
  }

  Future<void> cadastrarUsuario(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/usuarios'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Falha ao cadastrar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao cadastrar usuário: $e');
    }
  }

  Future<List<Usuario>> fetchUsuarios() async {
    final response = await http.get(Uri.parse('$baseUrl/usuarios'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonUsuarios = json.decode(response.body);
      return jsonUsuarios.map((jsonUsuario) {
        return Usuario.fromJson(jsonUsuario);
      }).toList();
    } else {
      throw Exception('Falha ao buscar usuários: ${response.statusCode}');
    }
  }

  Future<void> deleteUsuario(int usuarioId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/usuarios/$usuarioId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
      } else {
        throw Exception('Falha ao excluir usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao excluir usuário: $e');
    }
  }

  Future<void> deletarTodosUsuarios() async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/usuarios'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Falha ao excluir todos os usuários: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao excluir todos os usuários: $e');
    }
  }

  Future<void> editarUsuario(int usuarioId, Usuario novoUsuario) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/usuarios/$usuarioId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(novoUsuario.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Falha ao editar usuário: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao editar usuário: $e');
    }
  }
}
