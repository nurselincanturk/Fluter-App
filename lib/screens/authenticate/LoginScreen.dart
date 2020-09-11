import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/home2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/services/Service.dart';
import 'package:final_project/services/auth.dart';
class LoginScreen extends StatefulWidget {
  static const routeName = "/login";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Service service = Service();
  AuthService _auth = AuthService();


  Duration get loginTime => Duration(milliseconds: 2250);
  Future<String> _authUser(LoginData data) {
    return _auth.signInEmail(data).then((response) {
      if (response != null) {
        return null;
      } else {
        return "Giriş Yapılamadı";
      }
    });
  }

  Future<String> _signup(LoginData data) {
    return _auth.signUpEmail(data).then((response) {
      if (response != null) {
        return null;
      } else {
        return "Kullanıcı oluşturulamadı";
      }
    });
  }

  //Auth kısmına eklenecek
  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'Username not exists';
      // }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'APP',
      //logo: 'assets/qw.png',
      theme: LoginTheme(
       
        buttonStyle: TextStyle(color: Colors.white),
        textFieldStyle: TextStyle(color: Color.fromARGB(255, 66, 68, 107)),
          primaryColor: Color.fromARGB(255, 66, 68, 107),
          cardTheme: CardTheme(
              color: Color.fromARGB(255, 255, 250, 250), elevation: 55),
          bodyStyle: TextStyle(color: Color.fromARGB(255, 66, 68, 107)),
          accentColor: Color.fromARGB(255, 66, 68, 107),
          buttonTheme: LoginButtonTheme(
              backgroundColor: Color.fromARGB(255, 66, 68, 107)),

          titleStyle: TextStyle(
              color: Color.fromARGB(255, 255, 250, 250),
              fontWeight: FontWeight.w400)),
      onLogin: _authUser,
      onSignup: _signup,
         onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home2(),
        ));
      },   messages: LoginMessages(
        usernameHint: 'Email',
      passwordHint: 'Şifre',
        loginButton: 'Giriş yap',
        signupButton: 'Kayıt ol',
        forgotPasswordButton: 'Şifremi Unuttum?',
        recoverPasswordButton: 'HELP ME',
        goBackButton: 'Geri Dön',
        confirmPasswordError: 'Şifreler Uyumlu değil!',
        confirmPasswordHint: 'Şifre tekrarı',
        recoverPasswordDescription:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
        recoverPasswordSuccess: 'Password rescued successfully',
      ),
      // theme: LoginTheme(
       
      //   buttonStyle: TextStyle(color: Colors.white),
      //   textFieldStyle: TextStyle(color: Color.fromARGB(255, 182, 55, 12)),
      //     primaryColor: Color.fromARGB(255, 255, 250, 250),
      //     cardTheme: CardTheme(
      //         color: Color.fromARGB(255, 255, 250, 250), elevation: 55),
      //     bodyStyle: TextStyle(color: Color.fromARGB(255, 182, 55, 12)),
      //     accentColor: Color.fromARGB(255, 182, 55, 12),
      //     buttonTheme: LoginButtonTheme(
      //         backgroundColor: Color.fromARGB(255, 182, 55, 12)),

      //     titleStyle: TextStyle(
      //         color: Color.fromARGB(255, 182, 55, 12),
      //         fontWeight: FontWeight.w400)),
      // messages: LoginMessages(usernameHint: 'Username',
      //   passwordHint: 'Pass',
      //   confirmPasswordHint: 'Confirm',
      //   loginButton: 'LOG IN',
      //   signupButton: 'REGISER',
      //   forgotPasswordButton: 'Forgot huh?',
      //   recoverPasswordButton: 'HELP ME',
      //   goBackButton: 'GO BACK',
      //   confirmPasswordError: 'Not match!',),
      
      // onSubmitAnimationCompleted: () {
         
      // },
      onRecoverPassword: _recoverPassword,
    );
  }
}
