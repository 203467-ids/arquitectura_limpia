import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:self_host_group_chat_app/features/data/remote/data_sources/storage_provider.dart';
import 'package:self_host_group_chat_app/features/domain/entities/group_entity.dart';
import 'package:self_host_group_chat_app/features/domain/entities/user_entity.dart';
import 'package:self_host_group_chat_app/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:self_host_group_chat_app/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:self_host_group_chat_app/features/presentation/cubit/group/group_cubit.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/common.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/profile_widget.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/textfield_container.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/theme/style.dart';

import '../../../page_const.dart';
import 'home_page.dart';

class CreateGroupPage extends StatefulWidget {
  final String uid;

  const CreateGroupPage({Key? key, required this.uid}) : super(key: key);
  @override
  _CreateGroupPageState createState() => _CreateGroupPageState();
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  TextEditingController _groupNameController = TextEditingController();
  TextEditingController _numberUsersJoinController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _examTypeController = TextEditingController();
  TextEditingController _passwordAgainController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  int _selectGender = -1;
  int _selectExamType = -1;
  bool _isShowPassword = true;

  File? _image;
  String? _profileUrl;

  Future getImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);

          StorageProviderRemoteDataSource.uploadFile(file: _image!)
              .then((value) {
            print("profileUrl");
            setState(() {
              _profileUrl = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      toast("error $e");
    }
  }

  void dispose() {
    _examTypeController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    _numberUsersJoinController.dispose();
    _numberController.dispose();
    _passwordAgainController.dispose();
    _groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text("Crear groupo"),
      ),
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 35),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                getImage();
                //FIXME:
              },
              child: Column(
                children: [
                  Container(
                    height: 62,
                    width: 62,
                    decoration: BoxDecoration(
                      color: color747480,
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        child: profileWidget(image: _image)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Agregar imagen de grupo',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: greenColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 17,
            ),
            TextFieldContainer(
              controller: _groupNameController,
              keyboardType: TextInputType.text,
              hintText: 'nombre del grupo',
              prefixIcon: MaterialCommunityIcons.briefcase_edit_outline,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldContainer(
              controller: _numberUsersJoinController,
              keyboardType: TextInputType.emailAddress,
              hintText: 'numero de usuarios dentro del grupo',
              prefixIcon: MaterialIcons.format_list_numbered,
            ),
            SizedBox(
              height: 17,
            ),
            Divider(
              thickness: 2,
              indent: 120,
              endIndent: 120,
            ),
            SizedBox(
              height: 17,
            ),
            InkWell(
              onTap: () {
                _submit();
              },
              child: Container(
                alignment: Alignment.center,
                height: 44,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: greenColor,
                ),
                child: Text(
                  'Crear nuevo grupo',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 12,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Para crear nuevo grupo, usted debe agregar las ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colorC1C1C1),
                  ),
                  Text(
                    'Politicas de privacidad',
                    style: TextStyle(
                        color: greenColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'y ',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colorC1C1C1),
                  ),
                  Text(
                    'terminos ',
                    style: TextStyle(
                        color: greenColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'de uso',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: colorC1C1C1),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _submit() async {
    if (_image == null) {
      toast('Agregar foto de perfil');
      return;
    }
    if (_groupNameController.text.isEmpty) {
      toast('ingresa tu nombre');
      return;
    }
    if (_numberUsersJoinController.text.isEmpty) {
      toast('ingresa tu email');
      return;
    }

    BlocProvider.of<GroupCubit>(context).getCreateGroup(
        groupEntity: GroupEntity(
      lastMessage: "",
      uid: widget.uid,
      groupName: _groupNameController.text,
      creationTime: Timestamp.now(),
      groupProfileImage: _profileUrl!,
      joinUsers: "0",
      limitUsers: _numberUsersJoinController.text,
    ));
    toast("${_groupNameController.text} creado satisfactoriamente");
    _clear();
  }

  void _clear() {
    setState(() {
      _groupNameController.clear();
      _numberUsersJoinController.clear();
      _profileUrl = "";
      _image = null;
    });
  }
}
