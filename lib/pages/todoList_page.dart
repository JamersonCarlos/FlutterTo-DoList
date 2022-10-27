import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_tarefas_aplicattion/widgets/todoItem.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController ToDoController = TextEditingController();

  List<List<String>> todoList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Lista de Tarefas',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextField(
                        controller: ToDoController,
                        decoration: const InputDecoration(
                          hintText: 'Digite uma tarefa ',
                          border: OutlineInputBorder(),
                        ),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todoList.add([
                              ToDoController.text,
                              DateFormat('dd/MM/yyyy - HH:mm')
                                  .format(DateTime.now())
                            ]);
                            ToDoController.clear();
                          });
                        },
                        child: Icon(
                          Icons.add,
                          size: 24,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Flexible(
                    child: ListView(
                      children: [
                        for (List<String> todo in todoList)
                          ToDoItem(todoList: todo)
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Você possui ${todoList.length} tarefas pendentes',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todoList.clear();
                          });
                        },
                        child: Text(
                          'Limpar tudo',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
