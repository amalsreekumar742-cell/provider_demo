import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/features/to_do/data/model/todo_model.dart';
import 'package:to_do/features/to_do/presentation/provider/todo_provider.dart';
import 'package:to_do/features/to_do/presentation/view/todoadd.dart';

class ProductHome extends StatefulWidget {
  const ProductHome({super.key});

  @override
  State<ProductHome> createState() => _ProductHomeState();
}

class _ProductHomeState extends State<ProductHome> {
  TextEditingController updateController=TextEditingController();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      initdata();
    });
  }
  void initdata(){
      final todopro=context.read<TodoProvider>();
todopro.fetchTodo();
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
  final todopro=context.watch<TodoProvider>();

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>addproducts()));
      },child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: todopro.todos.length,
        shrinkWrap: true,
        
        itemBuilder: (BuildContext context, int index){
          final todoList=todopro.todos[index];
          return ListTile(title:Text("Product name:${todoList.title}"),
          subtitle:Text("Description:${todoList.des}"),
          trailing: 
             SizedBox(width: 120,
               child: Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    todopro.deleteTodo(todoList.id!);
                                  },
                                ),
                           
                                IconButton(
                                  icon: const Icon(Icons.update,
                                      color: Colors.blue),
                                  onPressed: () =>showUpdateDialog(todoList)
                                ),
                           
                ],
                           ),
             ),
          
          
           

 
          );
        }),
    );
  }
}