import 'package:flutter/material.dart';
import 'package:atividade2/services/TbEmerson.dart';

class EdicaoAniversariantePage extends StatefulWidget {
  final int id;
  final String nome;
  final DateTime dataNascimento;
  final String telefone;
  final String email;

  EdicaoAniversariantePage({
    required this.id,
    required this.nome,
    required this.dataNascimento,
    required this.telefone,
    required this.email,
  });

  @override
  _EdicaoAniversariantePageState createState() =>
      _EdicaoAniversariantePageState();
}

class _EdicaoAniversariantePageState extends State<EdicaoAniversariantePage> {
  late TextEditingController _nomeController;
  late TextEditingController _dataNascimentoController;
  late TextEditingController _telefoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.nome);
    _dataNascimentoController = TextEditingController(
      text: widget.dataNascimento.toString(),
    );
    _telefoneController = TextEditingController(text: widget.telefone);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _dataNascimentoController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> salvarEdicao() async {
    final int id = widget.id;
    final String nome = _nomeController.text;
    final DateTime dataNascimento = DateTime.parse(_dataNascimentoController.text);
    final String telefone = _telefoneController.text;
    final String email = _emailController.text;

    print('ID: $id');
    print('Nome: $nome');
    print('Data de Nascimento: $dataNascimento');
    print('Telefone: $telefone');
    print('Email: $email');

    try {
      await TbEmerson().atualizarAniversariante(id, nome, dataNascimento, telefone, email);

      Navigator.pop(context);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Falha ao salvar as alterações.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Aniversariante'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dataNascimentoController,
              decoration: InputDecoration(labelText: 'Data de Nascimento'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: salvarEdicao,
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
