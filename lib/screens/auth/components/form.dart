//Importing packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:testapp/screens/auth/components/rest_password.dart';
import '../../../models/user.dart';
import '../../../providers/firesotre_helper.dart';

//Importing pages
import 'rest_password.dart';
import '../../../enums.dart';

class CustomForm extends StatefulWidget {
  const CustomForm({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  //<------ Inisalisation de varaibles ------->
  //Make reference for database
  //Store the current user uid to flutter secure storage to stay logged in.
  final storage = const FlutterSecureStorage();
  //key for the form pour validate the inputs.
  final GlobalKey<FormState> _formKey = GlobalKey();
  //Contollers for text fields.
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmationPasswordTextController = TextEditingController();
  //Auth mode selection variable local store.
  AuthMode _authMode = AuthMode.login;
  //Chow the mot de pass or no.
  bool _obscure = true;

  //<------ Functions --------------------->

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmationPasswordTextController.dispose();
    //_formKey.currentState!.reset();
    super.dispose();
  }

  String _buttonText() => _authMode == AuthMode.login ? 'LOGIN' : 'SIGNUP';
  String _accountText() => _authMode == AuthMode.signup ? 'Log In' : 'Sign Up';

  void _clearFields() {
    // Clear the fields wen the auth state changes.
    _emailTextController.clear();
    _passwordTextController.clear();
    _confirmationPasswordTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: TextFormField(
              //focusNode:myFocusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Required*'),
                EmailValidator(errorText: 'Enter your valide email'),
              ]),
              controller: _emailTextController,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent,
                  ),
                ),
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordTextController,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Required*'),
                MinLengthValidator(
                  8,
                  errorText: 'Password must be at least 8 digits long',
                ),
              ]),
              obscureText: _obscure,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onLongPress: () {
                    setState(
                      () {
                        _obscure = !_obscure;
                      },
                    );
                  },
                  onLongPressEnd: (_) {
                    setState(
                      () {
                        _obscure = !_obscure;
                      },
                    );
                  },
                  child: const Icon(Icons.visibility),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.blueAccent,
                  ),
                ),
                labelText: 'Password',
              ),
            ),
          ),
          _authMode == AuthMode.login
              ? Container(
                  width: double.infinity,
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResetPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forget password?',
                      style: TextStyle(color: Colors.black54),
                      textAlign: TextAlign.end,
                    ),
                  ),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                  child: TextFormField(
                    mouseCursor: MouseCursor.defer,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _confirmationPasswordTextController,
                    validator: (value) {
                      if (value != _passwordTextController.text) {
                        return 'Password don\'t match.';
                      } else {
                        return null;
                      }
                    },
                    obscureText: _obscure,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              _obscure = !_obscure;
                            },
                          );
                        },
                        icon: const Icon(Icons.visibility),
                      ),
                      prefixIcon: const Icon(Icons.lock),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 2, color: Colors.blueAccent),
                      ),
                      labelText: 'Password Confirmation',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                  ),
                ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _formKey.currentState!.validate();
              showDialog(
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  });
              if (_authMode == AuthMode.signup) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                  email: _emailTextController.text,
                  password: _passwordTextController.text,
                )
                    .then((value) async {
                  //print('create new user');
                  final uid = value.user!.uid;
                  FirestorHelper.create(UserModel(
                      id: uid,
                      email: _emailTextController.text,
                      caseNumber: 0,
                      consultationsNumber: 0,
                      sessionsNumber: 0,
                      totalAmounts: 0,
                      totalPayments: 0));
                  await storage.write(key: 'uid', value: uid).then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/myhome');
                  });
                }).onError((error, stackTrace) {
                  //print('error ${error.toString()}');
                });
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: _emailTextController.text,
                        password: _passwordTextController.text)
                    .then((value) async {
                  await storage
                      .write(key: 'uid', value: value.user!.uid)
                      .then((value) {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/myhome');
                  });
                  //print(value);
                }).onError((error, stackTrace) {
                  //print('error ${error.toString()}');
                });
              }
            },
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(2),
              overlayColor: MaterialStateProperty.all(Colors.black12),
              shadowColor: MaterialStateProperty.all(Colors.pink.shade50),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              fixedSize: MaterialStateProperty.all(const Size(400, 55)),
            ),
            child: Text(
              _buttonText(),
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _authMode == AuthMode.login
                  ? const Text('Don\'t have an account?')
                  : const Text('You have an account?'),
              TextButton(
                onPressed: () {
                  setState(
                    () {
                      if (_authMode == AuthMode.login) {
                        _authMode = AuthMode.signup;
                      } else {
                        _authMode = AuthMode.login;
                      }
                      _clearFields();
                    },
                  );
                },
                child: Text(
                  _accountText(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
