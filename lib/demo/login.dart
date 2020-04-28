import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_svg/avd.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => new _Login();
}

class _Login extends State<Login> {
  //获取Key用来获取Form表单组件
  GlobalKey<FormState> loginKey = new GlobalKey<FormState>();
  String username;
  String password;
  bool isShowPassWord = false;

  void login() {
    //读取当前的Form状态
    var loginForm = loginKey.currentState;
    //验证Form表单
    if (loginForm.validate()) {
      loginForm.save();
      print('username: ' + username + ' password: ' + password);
    }
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("登录页"),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
              padding: EdgeInsets.only(top: 100.0, bottom: 10.0),
              child: SvgPicture.asset("imgs/logo_light.svg",
              width: 200,
                  color: Theme.of(context).iconTheme.color, semanticsLabel: "Sleep Early")
              ),
          new Container(
            padding: const EdgeInsets.all(16.0),
            child: new Form(
              key: loginKey,
              autovalidate: true,
              child: new Column(
                children: <Widget>[
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                        labelText: 'Email',
                        labelStyle: new TextStyle(
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 93, 93, 93)),
                        border: InputBorder.none,
                        // suffixIcon: new IconButton(
                        //   icon: new Icon(
                        //     Icons.close,
                        //     color: Color.fromARGB(255, 126, 126, 126),
                        //   ),
                        //   onPressed: () {
                            
                        //   },
                        // ),
                      ),
                      keyboardType: TextInputType.phone,
                      onSaved: (value) {
                        username = value;
                      },
                      validator: (phone) {
                        // if(phone.length == 0){
                        //   return '请输入手机号';
                        // }
                      },
                      onFieldSubmitted: (value) {},
                    ),
                  ),
                  new Container(
                    decoration: new BoxDecoration(
                        border: new Border(
                            bottom: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                                width: 1.0))),
                    child: new TextFormField(
                      decoration: new InputDecoration(
                          labelText: '密码',
                          labelStyle: new TextStyle(
                              fontSize: 15.0,
                              color: Color.fromARGB(255, 93, 93, 93)),
                          border: InputBorder.none,
                          suffixIcon: new IconButton(
                            icon: new Icon(
                              isShowPassWord
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color.fromARGB(255, 126, 126, 126),
                            ),
                            onPressed: showPassWord,
                          )),
                      obscureText: !isShowPassWord,
                      onSaved: (value) {
                        password = value;
                      },
                    ),
                  ),
                  new Container(
                    height: 45.0,
                    margin: EdgeInsets.only(top: 40.0),
                    child: new SizedBox.expand(
                      child: new RaisedButton(
                        onPressed: login,
                        color: Color.fromARGB(255, 61, 203, 128),
                        // color: Theme.of(context).accentColor,
                        child: new Text(
                          '登录',
                          style: TextStyle(
                            fontSize: 14.0,
                            // color: Color.fromARGB(255, 255, 255, 255)
                          ),
                        ),
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(45.0)),
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.only(top: 30.0),
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Container(
                            child: FlatButton(
                          onPressed: () {
                            print("跳转");
                          },
                          child: Text(
                            '注册账号',
                            style: TextStyle(
                              fontSize: 13.0,
                              // color: Color.fromARGB(255, 53, 53, 53)
                            ),
                          ),
                        )),
                        FlatButton(
                          onPressed: () {
                            print("跳转");
                          },
                          child: Text(
                            '忘记密码？',
                            style: TextStyle(
                              fontSize: 13.0,
                              // color: Color.fromARGB(255, 53, 53, 53)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
