// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:ui';

import 'package:cinemaster_app/gnav/gnav.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/models/streaming.dart';
import 'package:cinemaster_app/models/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cinemaster_app/styles.dart';

class SelectStreaming extends StatefulWidget {
  SelectStreaming({super.key});

  @override
  _SelectStreamingState createState() => _SelectStreamingState();
}

class _SelectStreamingState extends State<SelectStreaming> {
  List<Streaming> streamings = [];

  @override
  void initState() {
    super.initState();
    // Inicialize a lista de streamings no initState
    streamings = [
      Streaming(
        title: "Netflix",
        done: false,
        image: "lib/assets/images/netflix.png",
      ),
      Streaming(
        title: "HBO Max",
        done: false,
        image: "lib/assets/images/hbo_max.png",
      ),
      Streaming(
        title: "Prime Video",
        done: false,
        image: "lib/assets/images/prime_video.png",
      ),
      Streaming(
        title: "Globoplay",
        done: false,
        image: "lib/assets/images/logoGloboplay.png",
      ),
      Streaming(
        title: "Disney+",
        done: false,
        image: "lib/assets/images/logoDisney+.jpeg",
      ),
      Streaming(
        title: "Star+",
        done: false,
        image: "lib/assets/images/logoStar+.png",
      ),
      Streaming(
        title: "Apple TV+",
        done: false,
        image: "lib/assets/images/logoAppleTV.png",
      ),
      Streaming(
        title: "Paramount Plus",
        done: false,
        image: "lib/assets/images/logoParamount+.png",
      ),
    ];
  }

  List<String> streamingsSelecionados = [];

  void onChanged(Streaming streaming, bool newValue) {
    setState(() {
      streaming.done = newValue;
      if (newValue) {
        streamingsSelecionados.add(streaming.title!);
      } else {
        streamingsSelecionados.remove(streaming.title);
      }
    });
  }

  void concluirSelecao() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String uidDoUsuario = user.uid;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidDoUsuario)
          .set({
        'streamings': streamingsSelecionados,
      });
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return GoogleNavBar();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
        title: Center(
          child: Text(
            'Selecione os streamings que você possui',
            style: titleStyle,
            maxLines: 2,
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
                    'lib/assets/images/iconeCinemaster.png',
                    width: 39.27,
                    height: 45,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 5),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(0, 208, 108, 1),
                        minimumSize: Size(100, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: concluirSelecao,
                      child: Text('Concluir',
                          style: TextStyle(
                            color: Color.fromRGBO(3, 2, 23, 0.9),
                            fontSize: 18,
                          )),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: streamings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final streaming = streamings[index];
                    if (streaming.done == true) {
                      return Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(0, 208, 108, 1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Color.fromRGBO(0, 208, 108, 1),
                            width: 2,
                          ),
                        ),
                        child: CheckboxListTile(
                          title: Row(children: [
                            Image.asset(
                              streaming.image!,
                              height: 80,
                              width: 100,
                            ),
                            Container(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                streaming.title!,
                                style: subTitleStyle,
                              ),
                            )
                          ]),
                          key: Key(streaming.title!),
                          value: streaming.done,
                          onChanged: (bool? newValue) {
                            onChanged(streaming, newValue ?? false);
                          },
                          activeColor: Color.fromRGBO(0, 208, 108, 1),
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0x1eeeeadd),
                          borderRadius: BorderRadius.circular(10),
                          border: Border(),
                        ),
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 2.4049999714,
                              sigmaY: 2.4049999714,
                            ),
                            child: CheckboxListTile(
                              title: Row(children: [
                                Image.asset(
                                  streaming.image!,
                                  height: 80,
                                  width: 100,
                                ),
                                Container(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                    streaming.title!,
                                    style: subTitleStyle,
                                  ),
                                )
                              ]),
                              key: Key(streaming.title!),
                              value: streaming.done,
                              onChanged: (bool? newValue) {
                                onChanged(streaming, newValue ?? false);
                              },
                              activeColor: Color.fromRGBO(0, 208, 108, 1),
                            ),
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
      ),
    );
  }
}
