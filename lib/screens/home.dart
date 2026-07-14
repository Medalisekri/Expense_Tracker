import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/screens/add_expenses_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget{
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
 
}

class _HomeState extends ConsumerState<Home>{
  String selectedCategory='All';
  final List<String> categories=['All ' , 'Food' , 'Transport' , 'Other'];
  @override
  Widget build(BuildContext context) {
  final expenses = ref.watch(expenseProvider);
  final felitred = selectedCategory == 'All'? expenses
      :expenses.where((e)=>e.category==selectedCategory).toList();
  double total = expenses.fold(0.0, (sum , expenses)=> sum+expenses.amount);
return Scaffold(
  appBar: AppBar(
    title: Text('Home'),
    centerTitle: true,
    actions: [
     IconButton(onPressed: () async {
       await FirebaseAuth.instance.signOut();
       Navigator.pushReplacementNamed(context, '/login');
     }, icon: Icon(Icons.logout))
    ],
  ),
  body: 
  expenses.isEmpty?
  Column(
    children: [
      Text('There is no added expenses yet!')
    ],
    
  )
  :Column(
    children: [
      Row(
        children: [
          for(String cat in categories)
            GestureDetector(
              onTap: ()=>setState(()=>selectedCategory = cat 
                  
            ),
              child: Column(
                children: [
                  Text(cat),
                ],
              ),
            )
        ],
      ),
      Text('Your Expenses'),
      Text("Total: ${total.toStringAsFixed(3)} DT "),
      Expanded(child: 
      ListView.builder(itemCount: 
        felitred.length,
      itemBuilder: (context , index){
        return ListTile(
          onTap:(){Navigator.push(context , MaterialPageRoute(builder: (context)=> AddExpensesScreen(expense: felitred[index],)));},
          trailing: TextButton(onPressed: (){
            ref.read(expenseProvider.notifier).deleteExpense(felitred[index].id);
          }, child: Icon(Icons.delete)),
          title: Text(felitred[index].category),
            leading: Text('${felitred[index].date.day}/${felitred[index].date.month}/${felitred[index].date.year}'),
          subtitle: Text('${felitred[index].amount} DT '),
        );
      },))
    ],
  ),
    floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.pushNamed(context, '/addexpense');
    }),
);
  }
  
}