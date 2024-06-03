import 'package:fire_database/pages/admin_pages/home_admin.dart';
import 'package:fire_database/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/authentication_service.dart';
import '../services/util_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();



  Future<void>register()async{
    String pass = passwordController.text;
    String email = emailController.text;

    if(pass.isEmpty || pass.length < 2){
      Utils.fireSnackBar("Password is not filled", context);
    } else if(email.isEmpty || email.length < 2){
      Utils.fireSnackBar("Email is not filled", context);
    } else{
      User? user = await AuthenticationService.loginUser(email: email, password: pass);
      if(user != null){
        if(mounted){

          if(email=="akmalahmadjonov798@gmail.com" && pass == "akmal505"){
            Utils.fireSnackBar("Successfully registered", context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeAdminPage()));
          }else{
            Utils.fireSnackBar("Successfully registered", context);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
          }
        }
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
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

              const SizedBox(height: 10),

              TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context)=>const RegisterPage()
                        )
                    );
                  },
                  child: const Text(
                    "Do not have an account register here",
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
                child: const Text("Login",style: TextStyle(color: Colors.white, fontSize: 18)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
