import 'package:cityton_mobile/components/DisplaySnackbar.dart';
import 'package:cityton_mobile/components/framePage.dart';
import 'package:cityton_mobile/components/header.dart';
import 'package:cityton_mobile/screens/group/myGroup/editGroup/editGroup.bloc.dart';
import 'package:flutter/material.dart';
import 'package:cityton_mobile/constants/header.constants.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class EditGroup extends StatefulWidget {
  final Map arguments;

  EditGroup({@required this.arguments});

  @override
  EditGroupState createState() => EditGroupState();
}

class EditGroupState extends State<EditGroup> {
  EditGroupBloc editGroupBloc = EditGroupBloc();

    final GlobalKey<FormBuilderState> _editNameFormKey =
        GlobalKey<FormBuilderState>();
    TextEditingController _groupNameController = TextEditingController();

  int _groupId;
  String _groupName = "...";

  @override
  void initState() {
    super.initState();

    Map datas = widget.arguments;
    _groupId = datas["groupId"];
    _groupName = datas["groupName"];
    _groupNameController.text = _groupName;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FramePage(
        header: Header(
          title: "Edit a group",
          leadingState: HeaderLeading.DEAD_END,
        ),
        sideMenu: null,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FormBuilder(
              key: _editNameFormKey,
              readOnly: false,
              child: Column(children: <Widget>[
                FormBuilderTextField(
                  controller: _groupNameController,
                  attribute: "name",
                  decoration: InputDecoration(hintText: "Name"),
                  maxLines: 1,
                  validators: [
                    FormBuilderValidators.required(
                        errorText: "This field is required"),
                    FormBuilderValidators.minLength(3),
                    FormBuilderValidators.maxLength(50)
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: RaisedButton(
                      child: Text('Submit'),
                      onPressed: () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        
                        if (_editNameFormKey.currentState.saveAndValidate()) {
                          var response = await this
                              .editGroupBloc
                              .editName(_groupNameController.text, _groupId);
                          if (response.status == 200) {
                            DisplaySnackbar.createConfirmation(message: "Name has successfully been modified");
                            Get.back(result: true);
                          } else {
                            DisplaySnackbar.createError(
                                message: response.value);
                          }
                        }
                      }),
                ),
              ]),
            ),
          ],
        ));
  }
}
