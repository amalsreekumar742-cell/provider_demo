import 'package:flutter/cupertino.dart';
import 'package:to_do/features/to_do/data/model/todo_model.dart';
import 'package:to_do/features/to_do/repo/repo_todo.dart';

class TodoProvider extends ChangeNotifier {
  final RepoTodo repo;

  TodoProvider(this.repo);
  List<TodoModel> todos=[];
  bool isLoading=false;


  Future<void> fetchTodo() async{
    try{
      isLoading=true;
      notifyListeners();


       final result=await repo.getTodos();
       todos=result;
    }
    catch(e)
    {
      throw Exception(e);
    }
   finally{
    isLoading=false;
    notifyListeners();
   }

  }



   Future<void> addTodo(TodoModel todo) async{
    try{
     
       final newtodo=await repo.addTodo(todo);
       todos.add(newtodo);

    }
    catch(e)
    {
      throw Exception(e);
    }
    finally{
      notifyListeners();
    }
  

  }

Future<void> updateTodo(TodoModel todo) async {
  try {
    final updatedTodo = await repo.updateTodo(todo);

    
    final index = todos.indexWhere((e) => e.id == updatedTodo.id);

    if (index != -1) {
      todos[index] = updatedTodo;   
    }

  } catch (e) {
    throw Exception(e);
  } finally {
    notifyListeners();
  }
}

Future<void> deleteTodo(String docid) async{
 await repo.deleteTodo(docid);
  todos.removeWhere((t){
    return t.id==docid;
  });
  notifyListeners();
}


}