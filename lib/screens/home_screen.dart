import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/repositories/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/expense.dart';

class HomeScreen extends ConsumerWidget {


  @override
  Widget build(BuildContext context , WidgetRef ref) {
    final expenses = ref.watch(expenseProvider);
    double total = expenses.fold(0.0, (sum , expense) => sum +expense.amount);
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
        body: Column(
          children: [

            const SizedBox(height: 25,),
            Text("Your Expenses" , style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold ,color: Colors.orange
            ),
            ),
            const SizedBox(height: 10,),




                        Text('Total: ${total.toStringAsFixed(3)} DT ' , style: TextStyle(

                        ),),

                        Expanded(child:
                        ListView.builder(

                            itemCount: expenses.length,
                            itemBuilder: (context , index) {

                              return ListTile(

                                trailing: TextButton(onPressed: (){
                                  ref.read(expenseProvider.notifier).deleteExpense(expenses[index].id);
                                }
                                    , child: Icon(Icons.delete , color: Colors.red,)),
                                leading: Text('${expenses[index].date.day}/${expenses[index].date.month}/${expenses[index].date.year} ', style: TextStyle(
                                    fontSize: 13
                                ),),

                                title: Text(expenses[index].category , style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),),
                                subtitle: Text('${expenses[index].amount} DT'),

                              );

                            }),
                        ),
                      ]
        ),
        floatingActionButton: FloatingActionButton(onPressed: (){Navigator.pushNamed(context  , '/addexpenses');} , child: Icon(Icons.add),),
      );





    }
  }





