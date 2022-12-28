import 'package:flutter/material.dart';
import 'package:musicstation/bloc/app_blocs.dart';
import 'package:musicstation/repo/repository.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  State<Reset> createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      Repo.deleteall();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.greenAccent,
                        content: Text("Reset Successfully"),
                        duration: Duration(seconds: 1),
                      ));
                    });
                  },
                  child: const Text("Reset")),
              const SizedBox(
                height: 10,
              ),
              const Text("snap!!")
            ],
          ),
        ),
      ),
    );
  }
}
