import 'package:flutter/material.dart';
import 'tab_bar.dart' as prefix0;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late bool obscure;
  void _textObscured() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  void initState() {
    obscure = true;
    super.initState();
  }

  void _valid() {
    if (globalKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('correct validation')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('validation failled')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.black,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_sharp,
                color: Colors.black,
                size: 30,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.black,
                size: 30,
              ))
        ],
        title: const Text("Bottomnavigation Clipper"),
      ),
      bottomNavigationBar: const prefix0.TabBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: Form(
          key: globalKey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'User Name',
                      hintText: 'Please Enter user name here',
                      prefixIcon: Icon(
                        Icons.account_box_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 3,
                            style: BorderStyle.solid),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  validator: (value) {
                    int counterAlpha = 0;
                    int counterNumber = 0;
                    int counterSymbol = 0;
                    if (value!.length > 8) {
                      value.runes.forEach((int element) {
                        String char = String.fromCharCode(element);
                        if (char.contains(RegExp(r'[A-Z]')) ||
                            char.contains(RegExp(r'[a-z]'))) {
                          counterAlpha++;
                        } else if (char.contains(RegExp(r'[0-9]'))) {
                          counterNumber++;
                        } else if (char
                            .contains(RegExp(r'[@#!%^&*()=\|/?><-_$]'))) {
                          counterSymbol++;
                        }
                      });
                      if (counterAlpha >= 2 &&
                          counterNumber >= 2 &&
                          counterSymbol >= 2) {
                        return null;
                      } else {
                        return 'Please enter stronge password';
                      }
                    }
                    return 'Password length should be greater or equal 8';
                  },
                  obscuringCharacter: '*',
                  obscureText: obscure,
                  decoration: InputDecoration(
                      labelText: 'User Password',
                      hintText: 'Please Enter user Password here',
                      suffixIcon: GestureDetector(
                        onTap: _textObscured,
                        child: Icon(
                          obscure
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: Colors.black,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.password_sharp,
                        color: Colors.black,
                        size: 20,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.black,
                            width: 3,
                            style: BorderStyle.solid),
                      )),
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Forget password',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: _valid,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          tileMode: TileMode.mirror,
                          colors: [
                            Colors.deepPurpleAccent,
                            Colors.deepOrange,
                            Colors.purple.shade900
                          ],
                          stops: const [
                            0.1,
                            0.5,
                            0.9
                          ]),
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                    ),
                    child: const Center(
                      child: Text('Submitted',
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ),
                  ),
                )
              ]),
        )),
      ),
      drawer: const Drawer(),
    );
  }
}
