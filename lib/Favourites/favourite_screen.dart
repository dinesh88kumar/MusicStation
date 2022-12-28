import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicstation/bloc/app_events.dart';
import 'package:musicstation/bloc/app_states.dart';
import 'package:musicstation/models/model_class.dart';

import '../bloc/app_blocs.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetdataF());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 187, 226),
        title: const Text(
          "Favourite Songs List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoadedF) {
            List<Song> data = state.data;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text(data[index].songname),
                      subtitle: Text(data[index].authorname),
                      trailing: GestureDetector(
                          onTap: () {
                            setState(() {
                              bool favourite = data[index].favourite;
                              favourite = !favourite;
                              print(favourite);
                              _updatedata(
                                  context,
                                  data[index].id,
                                  data[index].songname,
                                  data[index].authorname,
                                  favourite);
                            });
                          },
                          child: data[index].favourite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Color.fromARGB(255, 249, 124, 115),
                                )
                              : const Icon(Icons.favorite_border)),
                    ),
                  );
                });
          } else if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _updatedata(context, id, song, author, favourite) {
    BlocProvider.of<ProductBloc>(context)
        .add(Update(song, author, favourite, id));
  }
}
