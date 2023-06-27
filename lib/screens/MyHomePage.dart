import 'package:atividade2/screens/CadastroPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:atividade2/services/TbEmerson.dart';
import 'package:atividade2/screens/AniversariantesPage.dart';

class MyHomePage extends StatelessWidget {
  final String title;
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
  final Map<String, int> monthMap = {
    'JANEIRO': 1,
    'FEVEREIRO': 2,
    'MARÇO': 3,
    'ABRIL': 4,
    'MAIO': 5,
    'JUNHO': 6,
    'JULHO': 7,
    'AGOSTO': 8,
    'SETEMBRO': 9,
    'OUTUBRO': 10,
    'NOVEMBRO': 11,
    'DEZEMBRO': 12,
  };

  MyHomePage({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              navigateToCadastroPage(context);
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black26,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (var i = 0; i < months.length; i += 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildMonthContainer(context, months[i], monthMap[months[i]]!),
                  if (i + 1 < months.length)
                    buildMonthContainer(context, months[i + 1], monthMap[months[i + 1]]!),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void navigateToAniversariantesPage(BuildContext context, int mes, String month) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AniversariantesPage(mes: mes, month: month),
      ),
    );
  }

  Widget buildMonthContainer(BuildContext context, String month, int mes) {
    return InkWell(
      onTap: () {
        navigateToAniversariantesPage(context, mes, month);
      },
      child: Container(
        width: 150,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: Text(
            month,
            style: TextStyle(color: Colors.white, fontSize: 26),
          ),
        ),
      ),
    );
  }

  void navigateToCadastroPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CadastroPage(),
      ),
    );
  }
}
