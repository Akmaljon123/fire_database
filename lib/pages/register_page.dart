import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/authentication_service.dart';
import '../services/util_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();



  Future<void>register()async{
    String name = nameController.text;
    String surname = surnameController.text;
    String email = emailController.text;
    String pass = passwordController.text;
    String confirmP = passwordConfirmController.text;
    if(name.isEmpty || name.length < 2){
      Utils.fireSnackBar("Name is not filled", context);
    }else if(surname.isEmpty || surname.length < 2){
      Utils.fireSnackBar("Surname is not filled", context);
    }else if(email.isEmpty || email.length < 2 || !email.contains("@")){
      Utils.fireSnackBar("Email is badly formatted", context);
    }else if(pass.isEmpty || pass.length < 5){
      Utils.fireSnackBar("Password should be more than 6 char", context);
    }else if(pass != confirmP){
      Utils.fireSnackBar("Confirm password is not same with password", context);
    }else{
      User? user = await AuthenticationService.registerUser(name: "$name/$surname", email: email, password: pass);
      if(user != null){
        if(mounted){
          Utils.fireSnackBar("Successfully registered", context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register",
          style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.w400
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.grey.shade900
                    ),
                    hintText: "Enter your name"
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: surnameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Surname",
                      labelStyle: TextStyle(
                          color: Colors.grey.shade900
                      ),
                      hintText: "Enter your surname"
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: Colors.grey.shade900
                      ),
                      hintText: "Enter your email address"
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: passwordController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Password",
                      labelStyle: TextStyle(
                          color: Colors.grey.shade900
                      ),
                      hintText: "Enter your password"
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  cursorColor: Colors.black,
                  controller: passwordConfirmController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      labelText: "Confirm",
                      labelStyle: TextStyle(
                          color: Colors.grey.shade900
                      ),
                      hintText: "Confirm you password"
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context)=>const LoginPage()
                        )
                    );
                  },
                  child: const Text(
                    "Already have an account login here",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15
                    ),
                  )
              ),

              const SizedBox(height: 25),

              MaterialButton(
                  onPressed: ()async{
                    await register();
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  minWidth: 340,
                  height: 50,
                  shape: const StadiumBorder(),
                  color: Colors.blue,
                  child: const Text("Register",style: TextStyle(color: Colors.white, fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
