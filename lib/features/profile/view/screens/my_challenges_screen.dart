import 'package:adcc/features/profile/view/sections/my_challenges/challenge_card.dart';
import 'package:flutter/material.dart';


class MyChallengesScreen extends StatefulWidget {
  const MyChallengesScreen({super.key});

  @override
  State<MyChallengesScreen> createState() => _MyChallengesScreenState();
}

class _MyChallengesScreenState extends State<MyChallengesScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6EFE6),
    appBar: AppBar(
  backgroundColor: const Color(0xffF6EFE6),
  elevation: 0,
  centerTitle: true,


  leading: Padding(
    padding: const EdgeInsets.only(left: 12),
    child: GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        height: 40,
        width: 40,
        decoration: const BoxDecoration(
          color: Color(0xffE8B4B0), 
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Color(0xffC62828), 
          size: 20,
        ),
      ),
    ),
  ),

  title: const Text(
    "My challenges",
    style: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 20,
    ),
  ),

  bottom: TabBar(
    controller: _tabController,
    indicatorColor: Color(0xffC62828),
    indicatorWeight: 3,
    labelColor: Color(0xffC62828),
    unselectedLabelColor: Color(0xff8E8E8E),
    labelStyle: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    tabs: const [
      Tab(text: "Completed"),
      Tab(text: "Upcoming"),
      Tab(text: "Cancelled"),
    ],
  ),
),


      body: TabBarView(
        controller: _tabController,
        children: const [
          ChallengeList(),  // Completed
          ChallengeList(),  // Upcoming
          ChallengeList(),  
        ],
      ),
    );
  }
}

class ChallengeList extends StatelessWidget {
  const ChallengeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: ChallengeCard(), 
        );
      },
    );
  }
}