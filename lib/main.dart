import 'package:cinemaster_app/gnav/gnav.dart';
import 'package:cinemaster_app/login_screen.dart';
import 'package:cinemaster_app/movie_details.dart';
import 'package:cinemaster_app/selectFilmes.dart';
import 'package:cinemaster_app/selectStreamings.dart';
import 'package:cinemaster_app/services/flutter_fire_auth.dart';
import 'package:cinemaster_app/signup_screen.dart';
import 'package:cinemaster_app/watchlist.dart';
import 'package:cinemaster_app/profile_screen.dart';
import 'package:cinemaster_app/wheel_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

const firebaseConfig = FirebaseOptions(
    apiKey: "AIzaSyDLJ0fKSK2ssN24lgRMBEHdk0atYXsiDkQ",
    authDomain: "cinemaster-app.firebaseapp.com",
    projectId: "cinemaster-app",
    storageBucket: "cinemaster-app.appspot.com",
    messagingSenderId: "886967521798",
    appId: "1:886967521798:web:b8322103bf4e81caabe987");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseConfig);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FlutterFireAuth(context).getLoggedUser();

    return MaterialApp(
      title: 'Cinemaster',
      home: user != null ? GoogleNavBar() : LoginScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        unselectedWidgetColor: Colors.white,
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_const_declarations

// Testando Código 'Search'
// import 'package:cinemaster_app/widgets/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'TMDb Search Test',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: SearchScreen(),
//     );
//   }
// }

// class SearchScreen extends StatefulWidget {
//   @override
//   _SearchScreenState createState() => _SearchScreenState();
// }

// class _SearchScreenState extends State<SearchScreen> {
//   TextEditingController _searchController = TextEditingController();
//   List<dynamic> searchResults = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('TMDb Search Test'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Pesquisar',
//                 suffixIcon: IconButton(
//                   icon: Icon(Icons.search),
//                   onPressed: () {
//                     _searchMovies();
//                   },
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: searchResults.length,
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(searchResults[index]['title']),
//                     subtitle: Text('ID: ${searchResults[index]['id']}'),

//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<List<dynamic>> searchMovies(String query) async {
//     final String apiKey = Constants.apiKey;
//     final String baseUrl = 'https://api.themoviedb.org/3/search/movie';

//     final Uri uri = Uri.parse('$baseUrl?api_key=$apiKey&query=$query');
//     final response = await http.get(uri);

//     if (response.statusCode == 200) {
//       return json.decode(response.body)['results'];
//     } else {
//       throw Exception('Falha ao carregar os filmes');
//     }
//   }

//   Future<void> _searchMovies() async {
//     String query = _searchController.text.trim();
//     if (query.isNotEmpty) {
//       List<dynamic> results = await searchMovies(query);

//       setState(() {
//         searchResults = results;
//       });
//     }
//   }
// }
