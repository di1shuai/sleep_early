import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sleep_early/common/routes.dart';

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
        key: key,
        maxLength: 40,
        autovalidate: false,
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

class RePasswordT extends StatefulWidget {
  final TextEditingController controller;
  final TextEditingController passwordC;

  RePasswordT({Key key, this.controller, this.passwordC}) : super(key: key);

  @override
  _RePasswordTState createState() =>
      _RePasswordTState(controller: controller, passwordC: passwordC);
}

class _RePasswordTState extends State<RePasswordT> {
  TextEditingController controller;
  TextEditingController passwordC;

  _RePasswordTState({Key key, this.controller, this.passwordC});

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
            labelText: "确认密码",
            hintText: "请再次输入密码",
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
          if (value.trim() != passwordC.text) {
            return "两次密码输入不一致";
          }
          return null;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp("[a-z,A-Z,0-9,@,.,_]")) //限制只允许输入字母和数字
        ]);
  }
}

class DeviceNameT extends StatelessWidget {
  final TextEditingController controller;

  final String oldDeviceName;

  final Icon icon;

  const DeviceNameT({
    Key key,
    this.controller,
    this.oldDeviceName,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        maxLength: 12,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: "设备名称",
            hintText: oldDeviceName,
            prefixIcon: icon),
        validator: (value) {
          if (value.trim().isEmpty) {
            return "设备名不能为空";
          } else if (value.trim().length < 1) {
            return "设备名不能少于1位";
          }
          return null;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp("[a-z,A-Z,0-9,@,.,_]|[\u4e00-\u9fa5]|"))
        ]);
  }
}

class NicknameT extends StatelessWidget {
  final TextEditingController controller;

  final String oldNickname;

  const NicknameT({
    Key key,
    this.controller,
    this.oldNickname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: true,
        maxLength: 8,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            labelText: "昵称",
            hintText: oldNickname,
            prefixIcon: Icon(Icons.person)),
        validator: (value) {
          if (value.trim().isEmpty) {
            return "昵称不能为空";
          } else if (value.trim().length < 2) {
            return "昵称不能少于2位";
          }
          return null;
        },
        inputFormatters: [
          WhitelistingTextInputFormatter(
              RegExp("[a-z,A-Z,0-9]|[\u4e00-\u9fa5]|"))
        ]);
  }
}

class AgreementT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CheckboxFormField(
      context: context,
      title: Row(
        children: <Widget>[
          Text("阅读并同意"),
          InkWell(
            onTap: () =>
                Navigator.of(context).pushNamed(Routes.USER_AGREEMENT_ROUTE),
            child: Text("《用户协议》", style: TextStyle(color: Colors.blue)),

            // Text("《用户协议》"),
          ),
          Text("和"),
          InkWell(
              onTap: () =>
                  Navigator.of(context).pushNamed(Routes.PRIVACY_POLICY_ROUTE),
              child: Text("《隐私政策》", style: TextStyle(color: Colors.blue))),
        ],
      ),
      validator: (value) {
        if (!value) {
          return "请阅读并同意《用户协议》和《隐私政策》";
        }
        return null;
      },
    );
  }
}

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      @required BuildContext context,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Text(
                        state.errorText,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}
