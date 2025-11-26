import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/features/to_do/data/model/todo_model.dart';
import 'package:to_do/features/to_do/presentation/provider/todo_provider.dart';

class addproducts extends StatefulWidget {
  const addproducts({super.key});

  @override
  State<addproducts> createState() => _addproductsState();
}

class _addproductsState extends State<addproducts> {
TextEditingController name=TextEditingController();
TextEditingController description=TextEditingController();
TextEditingController price=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details"),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          TextField(
            decoration: InputDecoration(
              labelText: "Product name",
              hintText: "Name of the product",
               border: OutlineInputBorder()
            ),
            controller: name,
          ),
          SizedBox(height: 15,),


          TextField(
            decoration: InputDecoration(
              labelText: "Description",
              hintText: "Description of the product",
              border: OutlineInputBorder()
            ),
            controller: description,
            
          ),
SizedBox(height: 15,),

           TextField(
            decoration: InputDecoration(
              labelText: "Price",
              hintText: "Name of the product",
              border: OutlineInputBorder()

            ),
            controller: price,
          ),
          SizedBox(height: 20,),

          SizedBox(height: 50, child: ElevatedButton(onPressed: ()=>submit(context), child: Text("Upload")))

        ],
      ),
    );
  }
  void submit(BuildContext context)async{
    final productName=name.text.trim();
    final num? Price=num.tryParse(price.text.trim());
    final Description=description.text.trim();


final newProduct=TodoModel(
  title: productName,
  price: Price,
  des: Description
  
);

final todoprovider= context.read<TodoProvider>();
await todoprovider.addTodo(newProduct);
setState(() {
  clear();
});

  }
  void clear()
  {
    name.clear();
    price.clear();
    description.clear();
  }
}