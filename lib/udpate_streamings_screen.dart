import 'package:cinemaster_app/models/streaming.dart';
import 'package:cinemaster_app/styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UpdateStreamingScreen extends StatefulWidget {
  @override
  _UpdateStreamingScreenState createState() => _UpdateStreamingScreenState();
}

class _UpdateStreamingScreenState extends State<UpdateStreamingScreen> {
  late List<String> selectedStreamings;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<List<String>> fetchUserSelectedStreamings(String uid) async {
    List<String> userSelectedStreamings = [];

    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (userDoc.exists) {
        Map<String, dynamic>? userData =
            userDoc.data() as Map<String, dynamic>?;

        if (userData != null && userData.containsKey('streamings')) {
          userSelectedStreamings =
              List<String>.from(userData['streamings'] as List<dynamic>);
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao buscar dados: $error'),
        ),
      );
    }

    return userSelectedStreamings;
  }

  void fetchData() async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      User? user = auth.currentUser;

      if (user != null) {
        // Buscar dados do Firebase para os streamings selecionados pelo usuário
        List<String> userSelectedStreamingsFromFirebase =
            await fetchUserSelectedStreamings(user.uid);

        print(
            'userSelectedStreamingsFromFirebase: $userSelectedStreamingsFromFirebase');

        setState(() {
          selectedStreamings =
              List<String>.from(userSelectedStreamingsFromFirebase);

          streamings.forEach((streaming) {
            streaming.done = selectedStreamings.contains(streaming.title);
          });
        });

        print('selectedStreamings: $selectedStreamings');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao buscar dados: $error'),
        ),
      );
    }
  }

  List<Streaming> streamings = [
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

  void onChanged(Streaming streaming, bool newValue) {
    print('Checkbox for ${streaming.title} changed to $newValue');
    setState(() {
      streaming.done = newValue;

      if (newValue) {
        // Se foi marcado, adicione à lista temporária
        if (!selectedStreamings.contains(streaming.title!)) {
          selectedStreamings.add(streaming.title!);
        }
      } else {
        // Se foi desmarcado, remova da lista temporária
        selectedStreamings.remove(streaming.title);
      }
    });
  }

  void concluirAtualizacao() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      String uidDoUsuario = user.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uidDoUsuario)
          .set({
        'streamings': buildStreamingsList(),
      });

      final snackBar = SnackBar(
        content: Text('Atualização realizada com sucesso!'),
        duration: Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      Navigator.pop(context); // Voltar para a tela anterior após a atualização
    }
  }

  List<String> buildStreamingsList() {
    List<String> markedStreamings = streamings
        .where((streaming) => streaming.done == true)
        .map((streaming) => streaming.title!)
        .toList();

    markedStreamings.addAll(
      selectedStreamings.where(
        (selectedStreaming) => !markedStreamings.contains(selectedStreaming),
      ),
    );

    print('Marked Streamings: $markedStreamings');
    return markedStreamings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 2, 23, 0.9),
        title: Center(
          child: Text(
            'Atualize os streamings que você possui',
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
                      onPressed: concluirAtualizacao,
                      child: Text(
                        'Concluir',
                        style: TextStyle(
                          color: Color.fromRGBO(3, 2, 23, 0.9),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: streamings.length,
                  itemBuilder: (BuildContext context, int index) {
                    final streaming = streamings[index];
                    return Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      decoration: BoxDecoration(
                        color: streaming.done == true
                            ? Color.fromRGBO(0, 208, 108, 1)
                            : Color(0x1eeeeadd),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: streaming.done == true
                              ? Color.fromRGBO(0, 208, 108, 1)
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Row(
                          children: [
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                        key: Key(streaming.title!),
                        value: streaming.done == true,
                        onChanged: (bool? newValue) {
                          onChanged(streaming, newValue ?? false);
                        },
                        activeColor: Color.fromRGBO(0, 208, 108, 1),
                      ),
                    );
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
