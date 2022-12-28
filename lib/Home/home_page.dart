import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicstation/bloc/app_blocs.dart';
import 'package:musicstation/bloc/app_events.dart';
import 'package:musicstation/bloc/app_states.dart';
import 'package:musicstation/models/model_class.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController songname = TextEditingController();
  TextEditingController authorname = TextEditingController();
  String song = "";
  String author = "";

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(Getdata());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 107, 187, 226),
        title: Text(
          "Songs List",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded) {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 107, 187, 226),
        child: const Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Text(
            "+",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
        onPressed: () => _create(),
      ),
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: songname,
                      decoration:
                          const InputDecoration(labelText: 'Song name......'),
                    ),
                    TextField(
                      controller: authorname,
                      decoration:
                          const InputDecoration(labelText: 'Singer name....'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          String song = songname.text;
                          String author = authorname.text;
                          _postdata(context);
                          Navigator.of(context).pop();
                        },
                        child: const Text("create"))
                  ]));
        });
  }

  void _postdata(context) {
    BlocProvider.of<ProductBloc>(context)
        .add(Create(songname.text, authorname.text, false));
  }

  void _updatedata(context, id, song, author, favourite) {
    BlocProvider.of<ProductBloc>(context)
        .add(Update(song, author, favourite, id));
  }
}
