import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/features/to_do/data/model/todo_model.dart';
import 'package:to_do/features/to_do/presentation/provider/todo_provider.dart';

class todo1 extends StatefulWidget {
  const todo1({super.key});

  @override
  State<todo1> createState() => _todo1State();
}

class _todo1State extends State<todo1> {
  final TextEditingController con1 = TextEditingController();
   final TextEditingController updateController = TextEditingController( );
   


@override
void initState() {
  super.initState();
 WidgetsBinding.instance.addPostFrameCallback((_){
 final provider = context.read<TodoProvider>();
  provider.fetchTodo();
 });
}


  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final val1=context.read<TodoProvider>();
        return AlertDialog(
          title: const Text("Add Task"),
          content: TextField(
            controller: con1,
            decoration: const InputDecoration(
              hintText: "Enter your task",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),

           
            ElevatedButton(
              onPressed: () async {
                String text = con1.text.trim();
                if (text.isEmpty) return;

                val1.addTodo(TodoModel(title: text));

                con1.clear();
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
  void showUpdateDialog(TodoModel todo) {
    updateController.text=todo.title??'';

            final val1=context.read<TodoProvider>();

    

    showDialog(
      context: context,
      builder: (context) {

        return AlertDialog(
          title: const Text("Update Task"),
          content: TextField(
            controller: updateController,
            decoration: const InputDecoration(hintText: "Update task text"),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel")),

            ElevatedButton(
              onPressed: () async {
                String newText = updateController.text.trim();
                if (newText.isEmpty) return;
val1.updateTodo(TodoModel(title: newText,id: todo.id));
                

                updateController.clear();
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  


  @override
  Widget build(BuildContext context) {
    final val1=context.watch<TodoProvider>();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do App"),
        centerTitle: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: showAddTaskDialog,
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                  itemCount: val1.todos.length,
                  itemBuilder: (context, index) {
                   final val2=val1.todos[index];
                    

                    

                    return SizedBox(
                      height: 80,
                      child: Card(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                val2.title!,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),

                            IconButton(
                              
                              onPressed: (
                                
                              )=>showUpdateDialog(val2), icon: Icon(Icons.update)),

                            
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red),
                              onPressed: () {
                                val1.deleteTodo(val2.id!);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )
          ),
        ],
      ),
    );
  }
}
