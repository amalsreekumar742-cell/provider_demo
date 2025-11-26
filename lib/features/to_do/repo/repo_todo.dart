import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/features/to_do/data/model/todo_model.dart';

class RepoTodo {
  final FirebaseFirestore db=FirebaseFirestore.instance;

  Future<List<TodoModel>> getTodos() async{
    try{
      final snapshot= await db.collection("notes").get();
      
      final list= snapshot.docs.map((doc)=>TodoModel.fromMap(doc.data()).copyWith(id: doc.id)).toList();
      return list;
      
    }
    catch(e){
      throw Exception(e);
    }
  }


  Future<TodoModel>addTodo(TodoModel todo) async{
    try{
      final docid= db.collection('notes').doc().id;
      final model=todo.copyWith(id: docid);
      await db.collection("notes").doc(docid).set(model.toMap());
      return model;
    }
    catch(e){
            throw Exception(e);

    }
  }


  Future<TodoModel>updateTodo(TodoModel todo) async{
    try{
      
      await db.collection("notes").doc(todo.id).update(todo.toMap());
      return todo;
    }
    catch(e){
            throw Exception(e);

    }
  }

  Future<bool> deleteTodo(String docid) async{
    try{
      await db.collection("notes").doc(docid).delete();
      return true;


    }
    catch(e){
            throw Exception(e);

    }

  }



}