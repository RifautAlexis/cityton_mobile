import 'package:cityton_mobile/components/framePage.dart';
import 'package:cityton_mobile/components/header.dart';
import 'package:cityton_mobile/components/iconText.dart';
import 'package:cityton_mobile/components/inputIcon.dart';
import 'package:cityton_mobile/components/mainSideMenu/mainSideMenu.dart';
import 'package:cityton_mobile/models/challenge.dart';
import 'package:cityton_mobile/screens/admin/challenge/adminChallenge.bloc.dart';
import 'package:flutter/material.dart';
import 'package:cityton_mobile/constants/header.constants.dart';

class AdminChallenge extends StatefulWidget {
  @override
  AdminChallengeState createState() => AdminChallengeState();
}

class AdminChallengeState extends State<AdminChallenge> {
  AdminChallengeBloc adminChallengeBloc = AdminChallengeBloc();

  DateTime finaldate;
  String searchText;

  @override
  void initState() {
    super.initState();
    this.adminChallengeBloc.search("", null);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callDatePicker() async {
    var order = await getDate();
    search();
    setState(() {
      finaldate = order;
    });
  }

  void search() {
    this.adminChallengeBloc.search(searchText, finaldate);
  }

  Future<DateTime> getDate() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FramePage(
        header: Header(
          title: "Challenge",
          leadingState: HeaderLeading.MENU,
          iconsAction: _buildHeaderIconsAction(context),
        ),
        sideMenu: MainSideMenu(),
        body: StreamBuilder(
            stream: adminChallengeBloc.challenges,
            builder: (BuildContext context,
                AsyncSnapshot<List<Challenge>> snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        flex: 0,
                        child: _buildSearchAndFilter(),
                      ),
                      Flexible(
                          flex: 1, child: _buildChallengeList(snapshot.data)),
                    ],
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            }));
  }

  Widget _buildSearchAndFilter() {
    return ExpansionTile(
      title: InputIcon(iconsAction: <IconAction>[
        IconAction(
            icon: Icon(Icons.search),
            action: (String input) {
              searchText = input;
              search();
            }),
      ]),
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Start date"),
            IconText.iconClickable(
              trailing: IconButtonCustom(
                  onAction: () {
                    callDatePicker();
                  },
                  icon: Icons.date_range),
              text: "$finaldate",
            ),
          ],
        )
      ],
    );
  }

  Widget _buildChallengeList(List<Challenge> challenges) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: challenges.length,
      itemBuilder: (BuildContext context, int index) {
        final item = challenges[index];

        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.statement),
          onTap: () => Navigator.popAndPushNamed(
              context, '/admin/challenge/edit', arguments: {
            "id": item.id,
            "title": item.title,
            "statement": item.statement
          }),
        );
      },
    );
  }

  List<IconButton> _buildHeaderIconsAction(BuildContext context) {
    return <IconButton>[
      IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () =>
              Navigator.pushNamed(context, '/admin/challenge/add')),
    ];
  }
}