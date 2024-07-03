import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../widgets/student_profile/quick_navigator.dart';
import '/modules/auth/login/data/local_storage/user_storage.dart';
import '/modules/auth/login/models/login_response_model.dart';
// import '../../../storage/user/user_json_model.dart';
import '/constants/color.dart';
import 'package:velocity_x/velocity_x.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  UserDataModel user = UserDataModel(
      fullName: 'Sobin Rai',
      avatar:
          'https://cdn.britannica.com/09/75509-050-86D8CBBF/Albert-Einstein.jpg',
      email: 'Sobin@sobin.com',
      role: 'STUDENT',
      userId: -1,
      isLogin: false,
      token: '');
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserStorage.user,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          // Future hasn't finished yet, return a placeholder
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.data == null) {
          return const Center(
            child: Text('Failed to fetch profile from local storage'),
          );
        } else {
          user = snapshot.data!;
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Student Profile'),
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          body: Container(
            padding: const EdgeInsets.all(12),
            color: themecolor,
            width: context.screenWidth,
            height: context.screenHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SafeArea(
                      child: Column(
                    children: [
                      20.heightBox,
                      Container(
                        padding: const EdgeInsets.all(8),
                        height: 170,
                        width: 350,
                        decoration: BoxDecoration(
                            color: backgrounghilghtcolor,
                            borderRadius: BorderRadius.circular(40)),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    20.heightBox,
                                    user.fullName.text
                                        .size(20)
                                        .align(TextAlign.left)
                                        .bold
                                        .color(titlecolor)
                                        .make(),
                                    user.email.text
                                        .size(15)
                                        .semiBold
                                        .align(TextAlign.left)
                                        .color(const Color.fromARGB(
                                            255, 88, 68, 132))
                                        .make(),
                                    20.heightBox,
                                    const Icon(
                                      FontAwesomeIcons.userGraduate,
                                      color: Color.fromARGB(255, 173, 178, 209),
                                    )
                                  ],
                                ),
                                // 130.widthBox,
                                Column(children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color.fromARGB(
                                                  255, 249, 249, 249)
                                              .withOpacity(0.2),
                                          blurRadius: 7,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.network(
                                        'http://${user.avatar}',
                                        width: 70,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  10.heightBox,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () => context
                                              .push('/instrcutorAccount'),
                                          icon: const Icon(
                                            FontAwesomeIcons.rightLeft,
                                            color: Color.fromARGB(
                                                255, 173, 178, 209),
                                            size: 20,
                                          ))
                                    ],
                                  )
                                ]),
                              ],
                            ),
                          ],
                        ),
                      ),
                      10.heightBox,
                      const Divider(
                        thickness: 0.5,
                        color: titlecolor,
                        endIndent: 20,
                        indent: 20,
                      ),
                      35.heightBox,
                      ListView(
                        padding: const EdgeInsets.all(10),
                        shrinkWrap: true,
                        children: [
                          QuickNavigatorButton(
                            labelText: 'Personal Information',
                            icon: Icons.person,
                            onPressed: () {},
                          ),
                          5.heightBox,
                          QuickNavigatorButton(
                            labelText: 'Book and Notes',
                            icon: FontAwesomeIcons.bookOpen,
                            onPressed: () {},
                          ),
                          5.heightBox,
                          QuickNavigatorButton(
                            labelText: 'Grade',
                            icon: Icons.assessment,
                            onPressed: () {},
                          ),
                          5.heightBox,
                          QuickNavigatorButton(
                            labelText: 'Setting & Privacy',
                            icon: Icons.settings,
                            onPressed: () {},
                          ),
                          5.heightBox,
                          QuickNavigatorButton(
                            labelText: 'Logout',
                            icon: FontAwesomeIcons.arrowRightFromBracket,
                            onPressed: () {
                              UserStorage.logout();
                              context.go('/login');
                            },
                          ),
                        ],
                      )
                    ],
                  )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
