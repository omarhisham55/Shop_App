import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/BoardModel.dart';
import 'screens_states.dart';

class ScreenManager extends Cubit<ScreenState> {
  ScreenManager() : super(InitialState());

  static ScreenManager screenManager(context) =>
      BlocProvider.of<ScreenManager>(context);

  final List<BoardingModal> board = [
    BoardingModal(
        boardImage: 'assets/images/img2.png',
        boardTitle: 'On Board 1 Title',
        boardBody: 'On Board 1 Body'),
    BoardingModal(
        boardImage: 'assets/images/img1.png',
        boardTitle: 'On Board 2 Title',
        boardBody: 'On Board 2 Body'),
    BoardingModal(
        boardImage: 'assets/images/img2.png',
        boardTitle: 'On Board 3 Title',
        boardBody: 'On Board 3 Body'),
  ];

  List<double> dotWidth = [30.0, 10.0, 10.0];
  bool isLast = false;

  void updateDotWidth(value) {
    dotWidth = [10.0, 10.0, 10.0];
    dotWidth[value] = 30.0;
    if (value == board.length - 1) {
      isLast = true;
    } else {
      isLast = false;
    }
    emit(ChangeBoardIndicatorState());
  }
}
