import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/login/data/local_storage/user_storage.dart';
import '../constants/nav_bar_items.dart';

part 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
      : super(NavigationState(NavbarItem.home, 1, false, false, false));

  void getNavBarItem(NavbarItem navbarItem) async {
    bool isAdmin = await UserStorage.isAdmin;
    bool isInstructor = await UserStorage.isInstructor;
    bool isStudent = await UserStorage.isStudent;
    switch (navbarItem) {
      case NavbarItem.home:
        emit(NavigationState(
            NavbarItem.home, 1, isAdmin, isInstructor, isStudent));
        break;
      case NavbarItem.assignment:
        emit(NavigationState(
            NavbarItem.assignment, 0, isAdmin, isInstructor, isStudent));
        break;
      case NavbarItem.myCourse:
        emit(NavigationState(
            NavbarItem.myCourse, 2, isAdmin, isInstructor, isStudent));
        break;
    }
  }
}
