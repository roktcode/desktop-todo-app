import 'package:flutter/material.dart';
import "models/Todo.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final List<Todo> _todoList = <Todo>[];

  void _addTodo() {
    if (!_formKey.currentState!.validate()) return;
    final maxId = _todoList.isNotEmpty ? _todoList.last.id : 1;
    final todo = Todo(id: maxId + 1, text: _controller.value.text);

    setState(() {
      _todoList.add(todo);
      _controller.clear();
    });
  }

  void _deleteTodo(int id) {
    setState(() {
      _todoList.removeWhere((todo) => todo.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(minWidth: 400, maxWidth: 600),
          margin: const EdgeInsets.symmetric(vertical: 80),
          child: Column(
            children: [
              const Text(
                "My Todos",
                style: TextStyle(fontSize: 40),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: TextFormField(
                      controller: _controller,
                      style: const TextStyle(fontSize: 20),
                      decoration: const InputDecoration(
                        hintText: 'Enter todo title',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter todo title';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Container(
                constraints:
                    const BoxConstraints.tightFor(width: 100, height: 50),
                margin: const EdgeInsets.only(bottom: 60),
                child: ElevatedButton(
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  onPressed: _addTodo,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  itemCount: _todoList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      hoverColor: Colors.black12,
                      title: Container(
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          _todoList[index].text,
                          style: TextStyle(
                            decoration: _todoList[index].isCompleted
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            decorationColor: Colors.red,
                            decorationThickness: 3,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _todoList[index].toggleCompleted();
                        });
                      },
                      trailing: IconButton(
                        onPressed: () {
                          _deleteTodo(_todoList[index].id);
                        },
                        icon: const Icon(Icons.delete),
                        // highlightColor: Colors.transparent,
                        // hoverColor: Colors.transparent,
                        splashRadius: 20,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
