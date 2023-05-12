import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/common.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/textfield_container.dart';
import 'package:self_host_group_chat_app/features/presentation/widgets/theme/style.dart';
import '../../../app_const.dart';
import '../../../page_const.dart';

class ForgetPassPage extends StatefulWidget {
  @override
  _ForgetPassPageState createState() => _ForgetPassPageState();
}

class _ForgetPassPageState extends State<ForgetPassPage> {
  TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Recuperar Password',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: greenColor),
                  )),
              SizedBox(
                height: 10,
              ),
              Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Lo siento! Debes insertar tu email y ${AppConst.appName} para poder recuperar tu password.",
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black.withOpacity(.6),
                    fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: 30,
              ),
              TextFieldContainer(
                controller: _emailController,
                prefixIcon: Icons.mail,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
              ),
              SizedBox(
                height: 20,
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
                    color: greenColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Text(
                    'Enviar Password de recuperacion a Email',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 27,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recordar informacion de la cuenta? ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, PageConst.loginPage, (route) => false);
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: greenColor),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_emailController.text.isEmpty) {
      toast('Escribe tu Email');
      return;
    }
  }
}
