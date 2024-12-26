import 'package:flutter/material.dart';
import 'package:electa/view_model/contract_linking.dart';
import 'package:provider/provider.dart';

class HomeScreenTestContract extends StatelessWidget {
  const HomeScreenTestContract({super.key});

  @override

  Widget build(BuildContext context){
    final contractLink = Provider.of<ContractLinking>(context);
    TextEditingController messageController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            contractLink.isLoading ? const Center(child: CircularProgressIndicator()): Center(
              child: Container(
                child: Form(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text("Message: ${contractLink.deployedName}", style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),),

                        TextFormField(
                          controller: messageController,
                          decoration: const InputDecoration(
                            hintText: 'Enter message',
                            border: OutlineInputBorder()
                          ),
                        ),

                        ElevatedButton(onPressed: (){
                          if(messageController.text.isEmpty){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter some messafe'), background: Colors.red,));
                          }
                          contractLink.setMessage(messageController.text);
                        }, child: const Text("Enter"))
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}