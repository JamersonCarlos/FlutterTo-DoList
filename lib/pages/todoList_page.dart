import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_tarefas_aplicattion/models/todoModel.dart';
import 'package:list_tarefas_aplicattion/repository/todo_repository.dart';
import 'package:list_tarefas_aplicattion/widgets/todoItem.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController ToDoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];
  Todo? todoBackup;
  bool pressButton = false;

  String? get isValidador {
    final text = ToDoController.value.text;

    if (text.isEmpty) {
      return 'Informe uma tarefa!';
    } else {
      return null;
    }
  }

  final _text = '';

  @override
  void initState() {
    super.initState();
    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                        decoration: InputDecoration(
                          hintText: 'Digite uma tarefa ',
                          border: const OutlineInputBorder(),
                          errorText: pressButton ? isValidador : null,
                        ),
                        onChanged: (text) => setState(() => _text),
                      )),
                      const SizedBox(
                        width: 8,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            pressButton = false;
                            if (ToDoController.value.text.isNotEmpty) {
                              todos.add(Todo(
                                  title: ToDoController.text,
                                  date: DateFormat('dd/MM/yyyy - HH:mm')
                                      .format(DateTime.now())
                                      .toString()));
                              todoRepository.saveTodoList(todos);
                              ToDoController.clear();
                            } else {
                              pressButton = true;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 24,
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
                        for (Todo todoItem in todos)
                          ToDoItem(
                            title: todoItem.title ?? '',
                            date: todoItem.date ?? '',
                            onDelete: onDelete,
                          )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Você possui ${todos.length} tarefas pendentes',
                        ),
                      ),
                      ElevatedButton(
                        onPressed: todos.isEmpty
                            ? null
                            : () {
                                boxConfirmDeletedListItems();
                              },
                        child: const Text(
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

  void boxConfirmDeletedListItems() {
    showDialog(
        context: context,
        builder: (builder) => AlertDialog(
              title: const Text(
                'Limpar tudo?',
                style: TextStyle(color: Colors.red),
              ),
              content: const Text(
                'Tem certeza disso ?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      todos.clear();
                      todoRepository.clearTodoList();
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Confirmar'),
                ),
              ],
            ));
  }

  void onDelete(String title) {
    for (int i = 0; i < todos.length; i++) {
      if (todos[i].title.toString().toLowerCase() == title.toLowerCase()) {
        todoBackup = todos[i];
        setState(() {
          todos.removeAt(i);
          todoRepository.saveTodoList(todos);
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Tarefa ${todoBackup!.title} foi removida com sucesso',
            style: const TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.grey,
          action: SnackBarAction(
            label: 'Desfazer',
            textColor: Colors.teal,
            onPressed: () {
              setState(() {
                todos.insert(i, todoBackup!);
                todoRepository.saveTodoList(todos);
              });
            },
          ),
        ));
      }
    }
  }
}
