import 'package:flutter/material.dart';
import 'package:shop_app/models/BoardModel.dart';
import 'package:shop_app/screens/cubit_screens/screens_bloc.dart';
import 'package:shop_app/screens/cubit_screens/screens_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/screens/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class BoardingScreen extends StatelessWidget {
  BoardingScreen({super.key});

  final PageController pageViewController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScreenManager, ScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          ScreenManager screenManager = ScreenManager.screenManager(context);
          return Scaffold(
              appBar: AppBar(
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextButton(
                        onPressed: () =>
                            replacePage(context, ShopLoginScreen()),
                        child: Text('SKIP')),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: PageView.builder(
                            onPageChanged: (value) {
                              screenManager.updateDotWidth(value);
                            },
                            controller: pageViewController,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                buildBoardingItem(screenManager.board[index]),
                            itemCount: screenManager.board.length,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        Row(
                          children: [
                            Text(''),
                            const Spacer(),
                            FloatingActionButton(
                              onPressed: () {
                                pageViewController.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeOut);
                                if (screenManager.isLast) {
                                  replacePage(context, ShopLoginScreen());
                                }
                              },
                              child: Icon(Icons.keyboard_arrow_right),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) =>
                                  pageIndicator(context, index),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 5.0),
                              itemCount: screenManager.board.length),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}

Widget buildBoardingItem(BoardingModal board) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Image(image: AssetImage(board.boardImage))),
        Text(
          board.boardTitle,
          style: TextStyle(fontSize: 24.0),
        ),
        const SizedBox(height: 15.0),
        Text(
          board.boardBody,
          style: TextStyle(fontSize: 14.0),
        )
      ],
    );

Widget pageIndicator(context, index) => AnimatedContainer(
      decoration: BoxDecoration(
          color: (ScreenManager.screenManager(context).dotWidth[index] == 30.0)
              ? defaultColor
              : inActiveColor,
          borderRadius: BorderRadius.circular(30.0)),
      width: ScreenManager.screenManager(context).dotWidth[index],
      duration: Duration(milliseconds: 300),
    );
