import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens_states.dart';
class ScreenManager extends Cubit<ScreenState> {
  ScreenManager() : super(InitialState());

  static ScreenManager nav(context) =>
      BlocProvider.of<ScreenManager>(context);
}
