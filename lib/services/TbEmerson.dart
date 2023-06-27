import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TbEmerson {
  static const baseUrl = "http://172.25.48.1:8080/";
  static const tb_emerson = "tb_emerson/";
  static const aniversariantes = "aniversariantes/";

  String getUrlTbEmerson() {
    return "$baseUrl$tb_emerson";
  }

  String getUrlAniversariantes(int mes) {
    return "$baseUrl$aniversariantes$mes";
  }

  Uri getUriTbEmerson() {
    return Uri.parse(getUrlTbEmerson());
  }

  Uri getUriAniversariantes(int mes) {
    return Uri.parse(getUrlAniversariantes(mes));
  }

  Future<List<dynamic>> fetchDadosMes(int mes) async {
    final List<String> months = [
      'JANEIRO',
      'FEVEREIRO',
      'MARÇO',
      'ABRIL',
      'MAIO',
      'JUNHO',
      'JULHO',
      'AGOSTO',
      'SETEMBRO',
      'OUTUBRO',
      'NOVEMBRO',
      'DEZEMBRO',
    ];

    String nomeMes = months[mes - 1];

    var response = await http.get(getUriAniversariantes(mes));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Falha ao carregar os dados');
    }
  }

  Future<void> excluirAniversariante(int id) async {
    final url = "${getUrlTbEmerson()}$id";

    var response = await http.delete(Uri.parse(url));
    if (response.statusCode == 200) {
      print('Aniversariante excluído com sucesso');
    } else {
      throw Exception('Falha ao excluir o aniversariante');
    }
  }


  Future<bool> cadastrarAniversariante(String nome, String telefone, String email, DateTime dataNascimento) async {
    final url = "${getUrlTbEmerson()}"; // URL para cadastrar o aniversariante

    final formattedDate = DateFormat('yyyy-MM-dd').format(dataNascimento);

    final Map<String, dynamic> requestBody = {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'data_nascimento': formattedDate,
    };

    final String jsonData = json.encode(requestBody);

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: jsonData,
    );

    if (response.statusCode == 201) {
      // Cadastro bem-sucedido
      return true;
    } else {
      // Falha no cadastro
      return false;
    }
  }

  Future<bool> atualizarAniversariante(int id, String nome, DateTime dataNascimento, String telefone, String email) async {
    final url = "${getUrlTbEmerson()}$id";

    final formattedDate = DateFormat('yyyy-MM-dd').format(dataNascimento);

    final Map<String, dynamic> requestBody = {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'data_nascimento': formattedDate,
    };

    final String jsonData = json.encode(requestBody);

    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-type': 'application/json'},
      body: jsonData,
    );

    if (response.statusCode == 200) {
      // Atualização bem-sucedida
      return true;
    } else {
      // Falha na atualização
      return false;
    }
  }


}
