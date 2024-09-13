part of 'navigation_cubit.dart';

class NavigationState {
  final NavbarItem navbarItem;
  final int index;
  bool isAdmin;
  bool isInstructor;
  bool isStudent;

  NavigationState(this.navbarItem, this.index, this.isAdmin, this.isInstructor,
      this.isStudent);

  List<Object> get props =>
      [navbarItem, index, isAdmin, isInstructor, isStudent];
}
