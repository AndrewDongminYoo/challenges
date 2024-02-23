// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CamiExampleApp());
}

const contents = [
  ContentModel(
    uri: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba',
    status: Status.notYet,
    owner: '까미',
    updatedAt: '2021-02-01',
  ),
  ContentModel(
    uri: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba',
    status: Status.notYet,
    owner: '까미',
    updatedAt: '2021-01-31',
  ),
  ContentModel(
    uri: 'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba',
    status: Status.notYet,
    owner: '까미',
    updatedAt: '2021-02-14',
  ),
  ContentModel(
    uri: 'https://images.unsplash.com/photo-1519052537078-e6302a4968d4',
    status: Status.completed,
    owner: '아띠',
    updatedAt: '2021-02-14',
  ),
  ContentModel(
    uri: 'https://images.unsplash.com/photo-1494256997604-768d1f608cac',
    status: Status.onGoing,
    owner: '까미',
    updatedAt: '2021-02-14',
  ),
  ContentModel(
    uri: 'https://images.unsplash.com/photo-1478098711619-5ab0b478d6e6',
    status: Status.onGoing,
    owner: '주인',
    updatedAt: '2021-02-14',
  ),
];

class CamiExampleApp extends StatelessWidget {
  const CamiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _pets = ['까미', '아띠', '주인'];
  String? _selectedPet;
  Status? _selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '검사 목록',
          style: TextStyle(
            color: Color(0xFF262626),
            fontSize: 16,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w600,
            height: 0.06,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios_new_outlined,
          size: 20,
          color: Color(0xFF1E1E1E),
        ),
      ),
      body: Column(
        children: [
          Wrap(
            spacing: 4,
            children: _pets
                .map(
                  (pet) => FilterChip(
                    label: Text(pet),
                    selected: _selectedPet == pet,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedPet = selected ? pet : null;
                      });
                    },
                  ),
                )
                .toList()
              ..addAll(
                Status.values.map(
                  (status) => FilterChip(
                    label: Text(genText(status)),
                    selected: _selectedStatus == status,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedStatus = selected ? status : null;
                      });
                    },
                  ),
                ),
              ),
          ),
          Expanded(
            child: CamiListViewExample(
              owner: _selectedPet ?? '까미',
              status: _selectedStatus ?? Status.notYet,
            ),
          ),
        ],
      ),
    );
  }
}

class ContentModel {
  const ContentModel({
    required this.uri,
    required this.status,
    required this.owner,
    required this.updatedAt,
  });

  final String uri;
  final Status status;
  final String owner;
  final String updatedAt;
}

enum Status {
  // 검사 전
  notYet,
  // 검사 진행 중
  onGoing,
  // 검사 완료
  completed,
}

String genText(Status status) {
  switch (status) {
    case Status.notYet:
      return '검사 전';
    case Status.onGoing:
      return '진행 중';
    case Status.completed:
      return '진행 완료';
  }
}

/// https://www.figma.com/file/uOOTFkJ7S43T76vg3wd1P5/[CAMI]-카미-MVP?&node-id=3617-15678
class CamiListViewExample extends StatelessWidget {
  const CamiListViewExample({
    super.key,
    required this.status,
    required this.owner,
  });

  final String owner;
  final Status status;

  @override
  Widget build(BuildContext context) {
    final filtered = contents.where((content) {
      return content.owner == owner && content.status == status;
    }).toList();

    return Container(
      alignment: Alignment.topCenter,
      child: filtered.isEmpty
          ? Text(
              '텅',
              style: GoogleFonts.kirangHaerang(
                fontSize: 400,
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return ContentCard(model: filtered[index]);
              },
              itemCount: filtered.length,
            ),
    );
  }
}

class ContentCard extends StatelessWidget {
  const ContentCard({
    super.key,
    required this.model,
  });

  final ContentModel model;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      color: Color(0xFF171717),
      fontSize: 14,
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w400,
      height: 0.07,
    );
    return Container(
      height: 208,
      width: MediaQuery.sizeOf(context).width,
      margin: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.topCenter,
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 320,
            height: 152,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: Image.network(model.uri).image,
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: 320,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${model.owner} 반려묘 성격유형검사',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      model.updatedAt,
                      style: const TextStyle(
                        color: Color(0xFF171717),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0.07,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF4F4F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            genText(model.status),
                            style: const TextStyle(
                              color: Color(0xFF171717),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 0.07,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
