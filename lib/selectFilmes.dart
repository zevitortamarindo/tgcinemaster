// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable

import 'package:cinemaster_app/selectStreamings.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/styles.dart';
import 'package:cinemaster_app/models/streaming.dart';

class SelectFilmes extends StatefulWidget {
  List<Filme> filmes = [];
  var contador = 0;

  SelectFilmes({super.key}) {
    filmes = [];
    filmes.add(Filme(
        title: "Avengers Endgame",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Indiana Jones",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Era uma vez em Hollywood",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Adão Negro",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Ligthyear",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Avengers Endgame",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Indiana Jones",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Era uma vez em Hollywood",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Adão Negro",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
    filmes.add(Filme(
        title: "Ligthyear",
        done: false,
        image: "lib/assets/images/endgame.jpg"));
  }

  @override
  State<SelectFilmes> createState() => _SelectFilmesState();
}

class _SelectFilmesState extends State<SelectFilmes> {
  final formValidVN = ValueNotifier<bool>(false);
  bool isButtonActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
          title: Center(
            child: Text(
              'Selecione 10 filmes dos seus favoritos',
              style: titleStyle,
              maxLines: 1,
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(23, 10, 23, 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'lib/assets/images/cinemaster_logo_dark_green-2x.png',
                      width: 39.27,
                      height: 45,
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(8, 0, 8, 0),
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Pesquise aqui',
                            hintStyle: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 5),
                      width: 90,
                      height: 43,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(0, 208, 108, 1),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          '${widget.contador}/10',
                          style: TextStyle(
                            color: Color.fromRGBO(3, 2, 23, 0.9),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 30, 0, 5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(0, 208, 108, 1),
                          minimumSize: Size(100, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: widget.contador >= 10
                            ? () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return SelectStreaming();
                                  }),
                                );
                              }
                            : null,
                        child: Text(
                          'Concluir',
                          style: TextStyle(
                              color: Color.fromRGBO(3, 2, 23, 0.9),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: widget.filmes.length,
                    itemBuilder: (BuildContext context, int index) {
                      final filme = widget.filmes[index];
                      if (filme.done == true) {
                        return GridTile(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color.fromRGBO(0, 208, 108, 1),
                                width: 2,
                              ),
                            ),
                            margin: EdgeInsets.all(8),
                            child: Image.asset(
                              filme.image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          footer: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Checkbox(
                                  key: Key(filme.title!),
                                  value: filme.done,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      filme.done = newValue;
                                      if (filme.done == true) {
                                        widget.contador += 1;
                                      } else {
                                        widget.contador -= 1;
                                      }
                                    });
                                  },
                                  activeColor: Color.fromRGBO(0, 208, 108, 1),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return GridTile(
                          child: Container(
                            margin: EdgeInsets.all(8),
                            child: Image.asset(
                              filme.image!,
                              fit: BoxFit.fill,
                            ),
                          ),
                          footer: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Checkbox(
                                  key: Key(filme.title!),
                                  value: filme.done,
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      filme.done = newValue;
                                      if (filme.done == true) {
                                        widget.contador += 1;
                                      } else {
                                        widget.contador -= 1;
                                      }
                                    });
                                  },
                                  activeColor: Color.fromRGBO(0, 208, 108, 1),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}


//código antigo
// Expanded(
//   child: GridView.builder(
//     gridDelegate:
//     const SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2,
//     ),
//     itemCount: widget.filmes.length,
//     itemBuilder: (BuildContext context, int index) {
//       final filme = widget.filmes[index];
//       return GridTile(
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             padding: EdgeInsets.all(8.0),
//             backgroundColor: Color.fromRGBO(3, 2, 23, 1),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0),
//             ),
//           ),
//           child: Image.network(
//             filme.image!,
//             height: double.infinity,
//             width: double.infinity,
//           ),
//         ),
//       );
//     },
//   ),
// )