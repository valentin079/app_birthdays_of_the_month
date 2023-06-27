import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:atividade2/services/TbEmerson.dart';

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  DateTime? dataNascimento;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
            TextField(
              controller: telefoneController,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            GestureDetector(
              onTap: () {
                _exibirSelecionadorData(context);
              },
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: dataNascimento != null
                        ? DateFormat('dd/MM/yyyy').format(dataNascimento!)
                        : '',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                cadastrarAniversariante();
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _exibirSelecionadorData(BuildContext context) async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (dataSelecionada != null) {
      setState(() {
        dataNascimento = dataSelecionada;
      });
    }
  }

  void cadastrarAniversariante() async {
    final nome = nomeController.text;
    final telefone = telefoneController.text;
    final email = emailController.text;

    if (dataNascimento == null) {
      print('Selecione a data de nascimento');
      return;
    }

    try {
      await TbEmerson().cadastrarAniversariante(nome, telefone, email, dataNascimento!);
      print('Aniversariante cadastrado com sucesso');
      Navigator.pop(context); // Retornar à tela anterior
    } catch (e) {
      print('Erro ao cadastrar aniversariante: $e');
    }
  }
}
