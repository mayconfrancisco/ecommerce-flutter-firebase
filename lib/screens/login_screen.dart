import 'package:ecommerce_flutter/models/user_model.dart';
import 'package:ecommerce_flutter/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: Text('Entrar'),
        actions: [
          FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text(
                'Criar conta',
              )),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              TextFormField(
                decoration: InputDecoration(hintText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (text) {
                  if (text.isEmpty || !text.contains("@")) {
                    return "E-mail inválido";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: 'Senha'),
                keyboardType: TextInputType.visiblePassword,
                controller: _passController,
                obscureText: true,
                validator: (text) {
                  return text.length <= 6
                      ? "Senha com no mínimo 4 dígitos "
                      : null;
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    'Esqueci minha senha',
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 44,
                child: RaisedButton(
                  child: Text(
                    'Entrar',
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      model.signIn(
                          mail: _emailController.text,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail);
                    }
                  },
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text('Falha ao autenticar'),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
    ));
  }
}
