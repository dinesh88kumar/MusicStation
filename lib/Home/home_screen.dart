import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicstation/Home/home_page.dart';
import 'package:musicstation/bloc/app_blocs.dart';
import 'package:musicstation/bloc/app_events.dart';
import 'package:musicstation/bloc/app_states.dart';
import 'package:musicstation/repo/repository.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> sk = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ProductBloc(repo: RepositoryProvider.of<Repo>(context)),
        child: Scaffold(
          body: BlocListener<ProductBloc, ProductState>(
            listener: (context, state) {
              if (state is ProductAdded) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.greenAccent,
                  content: Text("Added..."),
                  duration: Duration(seconds: 1),
                ));
              }
            },
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductAdding) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return const Center(child: Text("Something went Wrong"));
                }
                return const HomePage();
              },
            ),
          ),
          key: sk,
        ));
  }
}
