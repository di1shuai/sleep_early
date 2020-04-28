import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  Widget child;

  Input({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
        // decoration: new BoxDecoration(
        //     border: new Border(
        //         bottom: BorderSide(
        //             color: Color.fromARGB(255, 240, 240, 240), width: 1.0))),
        child: child);
  }
}

class UsernameT extends StatelessWidget {
  final TextEditingController controller;

  const UsernameT({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        maxLength: 40,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: "用户名",
            hintText: "邮箱",
            prefixIcon: Icon(Icons.person)),
        validator: (value) {
          if (value.trim().isEmpty) {
            return "用户名不能为空";
          } else if (value.trim().length < 6) {
            return "用户名不能少于6位";
          } else if (!RegexUtil.isEmail(value.trim())) {
            return "请输入正确的邮件地址";
          }
          return null;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp("[a-z,A-Z,0-9,@,.,_]")) //限制只允许输入字母和数字
        ]);
  }
}

class PasswordT extends StatefulWidget {
  final TextEditingController controller;

  PasswordT({Key key, this.controller}) : super(key: key);

  @override
  _PasswordTState createState() => _PasswordTState(controller: controller);
}

class _PasswordTState extends State<PasswordT> {
  TextEditingController controller;

  _PasswordTState({Key key, this.controller});

  bool isShowPassWord = false;

  @override
  Widget build(Object context) {
    return TextFormField(
        controller: controller,
        maxLength: 16,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: "密码",
            hintText: "您的登录密码",
            prefixIcon: Icon(Icons.lock),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isShowPassWord = !isShowPassWord;
                  });
                },
                icon: Icon(
                  isShowPassWord ? Icons.visibility_off : Icons.visibility,
                ))),
        obscureText: !isShowPassWord,
        validator: (value) {
          if (value.trim().isEmpty) {
            return "密码不能为空";
          } else if (value.trim().length < 6) {
            return "密码不能少于6位";
          }
          return null;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp("[a-z,A-Z,0-9,@,.,_]")) //限制只允许输入字母和数字
        ]);
  }
}
