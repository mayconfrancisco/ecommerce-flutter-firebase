import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  DrawerTile(this.icon, this.text, this.pageController, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32,
                color: page == pageController.page.round()
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              const SizedBox(
                width: 32,
              ),
              Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    color: page == pageController.page.round()
                        ? Theme.of(context).primaryColor
                        : Colors.black),
              )
            ],
          ),
        ),
      ),
    );
  }
}
