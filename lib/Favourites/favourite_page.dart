import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicstation/Favourites/favourite_screen.dart';
import 'package:musicstation/bloc/app_blocs.dart';
import 'package:musicstation/bloc/app_states.dart';
import 'package:musicstation/repo/repository.dart';

class FavPage extends StatefulWidget {
  const FavPage({Key? key}) : super(key: key);

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
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
                  content: Text("Song Added"),
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
                return const Favourites();
              },
            ),
          ),
          key: sk,
        ));
  }
}
