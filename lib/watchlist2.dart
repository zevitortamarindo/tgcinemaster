import 'package:cinemaster_app/movie_details.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cinemaster_app/homePage.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/wheel_screen.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({super.key});

  @override
  State<Watchlist> createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
        iconSize: 20,
        backgroundColor: const Color(0xff1f1d36),
        color: Colors.white,
        activeColor: const Color(0xff00d06c),
        onTabChange: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return Home();
              }),
            );
          }
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return const Watchlist();
              }),
            );
          }
          if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return WheelScreen();
              }),
            );
          }
          if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) {
                return const ProfileScreen();
              }),
            );
          }
        },
        tabs: [
          GButton(
            icon: Icons.home,
            text: 'Início',
            gap: 5,
            onPressed: () {
              setState(() {
                index = 0;
              });
            },
          ),
          GButton(
            icon: Icons.bookmark_outline_rounded,
            text: 'Watchlist',
            gap: 5,
            onPressed: () {
              setState(() {
                index = 1;
              });
            },
          ),
          GButton(
            icon: Icons.support_outlined,
            text: 'Roleta',
            gap: 5,
            onPressed: () {
              setState(() {
                index = 2;
              });
            },
          ),
          GButton(
            icon: Icons.person,
            text: 'Perfil',
            gap: 5,
            onPressed: () {
              setState(() {
                index = 3;
              });
            },
          ),
        ],
      ),
      backgroundColor: const Color.fromRGBO(3, 2, 23, 0.9),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(3, 2, 23, 0.9),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: 30,
              child: Image.asset(
                'lib/assets/images/cinemaster_logo_dark_green-2x.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              child: const Text(
                'Minha Watchlist',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: <Widget>[
          ListTile(
            leading: SizedBox(
              height: 100,
              width: 50,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return Home();
                    }),
                  );
                },
                child: Image.asset(
                  'lib/assets/images/spider_man_image.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            title: const Text('Spider Man - No Way to Home'),
            subtitle: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                            width: 20,
                            child: Image.asset(
                              'lib/assets/images/classificacao-12-anos-logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text('(2017)'),
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [Text('Ação / Ficção')],
                      ),
                      const Row(
                        children: [
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('2h 28min')
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Disponível em:'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25,
                            child: Image.asset(
                              'lib/assets/images/hbo_max.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: 25,
                            child: Image.asset(
                              'lib/assets/images/prime_video.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          // ListTile(
          //   leading: SizedBox(
          //     height: 100,
          //     width: 50,
          //     child: Image.asset(
          //       'lib/assets/images/stranger_things.png',
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          //   title: Text('Stranger Things'),
          //   subtitle: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 20,
          //                   width: 20,
          //                   child: Image.asset(
          //                     'lib/assets/images/classificacao-16-anos.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Text('(2016)'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [Text('Drama')],
          //             ),
          //             Row(
          //               children: [Text('4 Temporadas')],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Text('Disponível em:'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 25,
          //                   child: Image.asset(
          //                     'lib/assets/images/netflix.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // ListTile(
          //   leading: SizedBox(
          //     height: 100,
          //     width: 50,
          //     child: Image.asset(
          //       'lib/assets/images/batman.png',
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          //   title: Text('The Batman'),
          //   subtitle: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 20,
          //                   width: 20,
          //                   child: Image.asset(
          //                     'lib/assets/images/classificacao-14-anos.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Text('(2022)'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [Text('Crime, Drama')],
          //             ),
          //             Row(
          //               children: [
          //                 Icon(
          //                   Icons.access_time,
          //                   color: Colors.grey,
          //                 ),
          //                 SizedBox(
          //                   width: 15,
          //                 ),
          //                 Text('2h 57min')
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Text('Disponível em:'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 25,
          //                   child: Image.asset(
          //                     'lib/assets/images/hbo_max.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // ListTile(
          //   leading: SizedBox(
          //     height: 100,
          //     width: 50,
          //     child: Image.asset(
          //       'lib/assets/images/la_casa_papel.png',
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          //   title: Text('La Casa de Papel'),
          //   subtitle: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 20,
          //                   width: 20,
          //                   child: Image.asset(
          //                     'lib/assets/images/classificacao-16-anos.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Text('(2017)'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [Text('Drama, Thriller')],
          //             ),
          //             Row(
          //               children: [Text('5 Temporadas')],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Text('Disponível em:'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 25,
          //                   child: Image.asset(
          //                     'lib/assets/images/netflix.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
          // ListTile(
          //   leading: SizedBox(
          //     height: 100,
          //     width: 50,
          //     child: Image.asset(
          //       'lib/assets/images/Moonlight.png',
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          //   title: Text('Moonlight'),
          //   subtitle: Row(
          //     children: [
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 20,
          //                   width: 20,
          //                   child: Image.asset(
          //                     'lib/assets/images/classificacao-16-anos.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 20,
          //                 ),
          //                 Text('(2016)'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [Text('Drama, Comédia')],
          //             ),
          //             Row(
          //               children: [
          //                 Icon(
          //                   Icons.access_time,
          //                   color: Colors.grey,
          //                 ),
          //                 SizedBox(
          //                   width: 15,
          //                 ),
          //                 Text('1h 51min')
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //       Expanded(
          //         child: Column(
          //           children: [
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Text('Disponível em:'),
          //               ],
          //             ),
          //             Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 25,
          //                   child: Image.asset(
          //                     'lib/assets/images/prime_video.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 SizedBox(
          //                   height: 25,
          //                   child: Image.asset(
          //                     'lib/assets/images/hbo_max.png',
          //                     fit: BoxFit.contain,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
