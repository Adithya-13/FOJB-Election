import 'package:flutter/material.dart';
import 'package:fojb_election/presentation/utils/utils.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        boxShadow: Helper.getNavBarShadow(),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        bottom: true,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () => onItemTapped(0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    selectedIndex == 0
                        ? Icons.home
                        : Icons.home_outlined,
                    color: selectedIndex == 0 ? AppTheme.green : AppTheme.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onItemTapped(1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    selectedIndex == 1
                        ? Icons.how_to_vote
                        : Icons.how_to_vote_outlined,
                    color: selectedIndex == 1 ? AppTheme.green : AppTheme.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => onItemTapped(2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(
                    selectedIndex == 2
                        ? Icons.person
                        : Icons.person_outlined,
                    color: selectedIndex == 2 ? AppTheme.green : AppTheme.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
