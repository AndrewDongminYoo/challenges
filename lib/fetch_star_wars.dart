/// This example code can be run immediately
/// via the dartpad at the following address.
/// Author: AndrewDongminYoo<ydm2790@gmail.com>
/// https://dartpad.dev/?id=2a232254632bde2fae42f2fdc6f62296

// 🎯 Dart imports:
import 'dart:convert';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StarWars API Playground',
      home: FetchStarWars(),
    );
  }
}

class FetchStarWars extends StatefulWidget {
  const FetchStarWars({super.key});

  @override
  State<FetchStarWars> createState() => _FetchStarWarsState();
}

class _FetchStarWarsState extends State<FetchStarWars> {
  final controller = TextEditingController(text: 'sky');
  List<Person> results = [];
  List<String> history = [];

  @override
  void initState() {
    super.initState();
    searchSWApi(controller.text);
  }

  Future<void> searchSWApi(String query) async {
    if (query.isEmpty) {
      setState(() {
        results = [];
      });
    }
    history.add(query);
    try {
      final response = await http.get(
        Uri.parse('https://swapi.dev/api/people/?search=$query'),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = Result.fromJson(data as Map<String, dynamic>);
        setState(() {
          results = result.results;
        });
      } else {
        throw UnsupportedError(
          'Request failed with status: ${response.statusCode}.',
        );
      }
    } catch (e) {
      // 에러 처리
      print(e);
      results = [];
    }
  }

  // 검색 기록 메뉴 아이템을 빌드하는 함수
  List<PopupMenuEntry<String>> buildSearchHistory() {
    return history.map((word) {
      return PopupMenuItem<String>(
        value: word,
        child: Text(
          word,
          style: GoogleFonts.juliusSansOne(
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'StarWars API',
          style: GoogleFonts.bungeeShade(
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8) + const EdgeInsets.only(bottom: 8),
            child: TextField(
              controller: controller,
              style: GoogleFonts.bungee(),
              decoration: InputDecoration(
                labelText: 'Search Star Wars Characters',
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                    width: 6,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                    width: 6,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                    width: 6,
                  ),
                ),
                labelStyle: GoogleFonts.bungee(color: Colors.grey.shade300),
                prefixIcon: PopupMenuButton<String>(
                  color: Colors.grey.shade300,
                  icon: const Icon(
                    Icons.search,
                    weight: 50,
                    size: 25,
                  ),
                  onSelected: (value) {
                    controller.text = value;
                    // 검색 함수를 호출하거나 다른 동작 수행
                  },
                  itemBuilder: (BuildContext context) {
                    return buildSearchHistory();
                  },
                ),
                suffix: TextButton(
                  child: Text('search', style: GoogleFonts.bungee()),
                  onPressed: () {
                    searchSWApi(controller.text);
                  },
                ),
              ),
              onSubmitted: searchSWApi,
            ),
          ),
          Expanded(
            child: results.isEmpty
                ? Center(
                    child: Text(
                      'No results were found for "${controller.text}",\n'
                      'please try a different word.',
                      style: GoogleFonts.juliusSansOne(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final person = results[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 14,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                          ),
                        ),
                        child: ListTile(
                          title: Text(
                            '${person.name} | ${person.gender}',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.bungee(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          subtitle: Text(
                            '${person.height} / ${person.mass}\n'
                            'Hair Color: ${person.hairColor} | Skin Color: ${person.skinColor}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.juliusSansOne(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          style: ListTileStyle.drawer,
                          tileColor: Colors.grey,
                          titleAlignment: ListTileTitleAlignment.center,
                          isThreeLine: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class Person {
  const Person({
    required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.skinColor,
    required this.eyeColor,
    required this.birthYear,
    required this.gender,
    required this.homeworld,
    required this.films,
    required this.species,
    required this.vehicles,
    required this.starships,
    required this.created,
    required this.edited,
    required this.url,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      name: json['name'],
      height: json['height'],
      mass: json['mass'],
      hairColor: json['hair_color'],
      skinColor: json['skin_color'],
      eyeColor: json['eye_color'],
      birthYear: json['birth_year'],
      gender: json['gender'],
      homeworld: json['homeworld'],
      created: json['created'],
      edited: json['edited'],
      url: json['url'],
      films: List<String>.from(json['films']),
      species: List<String>.from(json['species']),
      vehicles: List<String>.from(json['vehicles']),
      starships: List<String>.from(json['starships']),
    );
  }

  // 인물의 이름.
  final String name;
  // 인물의 키(미터).
  final String height;
  // 인물의 질량(킬로그램).
  final String mass;
  // 인물의 머리 색깔.
  final String hairColor;
  // 인물의 피부색.
  final String skinColor;
  // 인물의 눈동자 색.
  final String eyeColor;
  // 인물의 출생 연도. BBY(야빈 전투 이전) 또는 ABY(야빈 전투 이후).
  final String birthYear;
  // 인물의 성별(알고 있는 경우). "FEMAIL"|"MAIL"|"N/A"
  final String gender;
  // 인물이 태어난 행성 리소스의 URL.
  final String homeworld;
  // 인물이 출연했던 영화 리소스의 URL 배열.
  final List<String> films;
  // 인물이 속한 종족 자원의 URL.
  final List<String> species;
  // 인물이 조종한 전차 자원의 배열.
  final List<String> vehicles;
  // 인물이 조종한 우주선 자원의 배열.
  final List<String> starships;
  // 리소스를 생성한 시간의 ISO 8601 날짜 형식.
  final String created;
  // 리소스를 수정한 시간의 ISO 8601 날짜 형식.
  final String edited;
  // 리소스의 URL.
  final String url;
}

class Result {
  const Result({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      count: json['count'],
      next: json['next'],
      previous: json['previous'],
      results: List<Person>.from(
        json['results']
            .map((dynamic x) => Person.fromJson(x as Map<String, dynamic>)),
      ),
    );
  }

  final int count;
  final String? next;
  final String? previous;
  final List<Person> results;
}
