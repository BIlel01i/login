import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tawhida_login/components/my_button.dart';
import 'package:tawhida_login/components/my_textfield.dart';
import 'package:tawhida_login/pages/home_page.dart';
class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key , required this.onTap });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}


class _RegisterPageState extends State<RegisterPage> {
 
  // text editing controllers
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final  confirmPasswordController = TextEditingController();
  final phoneController=TextEditingController();
  final cnamController=TextEditingController();
  final phonefriendController=TextEditingController();
  final cinController= TextEditingController();
  // sign user in method
  void signUserUp() async {

    showDialog(
      context: context, 
      builder:(context){
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try{
      if(passwordController.text == confirmPasswordController.text){
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
        String uid = userCredential.user!.uid;
         FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'name': nameController.text,
        'CNAM':cnamController.text,
        'phone_friend':phonefriendController.text,
        'phone': phoneController.text,
        'CIN':  cinController.text,
      });
        // Navigate to HomePage with userId
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(userId: uid),
        ),
      );
    

      }else {
        //show error message
        wrongPasswordMessage();
      }
      Navigator.pop(context);
    }on FirebaseAuthException catch (e){
      Navigator.pop(context);
      //wrong email 
      if (e.code=='user-not-found'){
        //show error to user 
        wrongEmailMessage(); 

      } else if (e.code == 'wrong-password'){
        //show error to user
        wrongPasswordMessage();
      }
    }

   
  }
  
  //wrong email message popup
  void wrongEmailMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          title: Text('Incorrect Email '),
        );
      }
    );
  }
  void wrongPasswordMessage(){
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          title: Text('Incorrect Password '),
        );
      }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                  decoration: BoxDecoration(
                  image:DecorationImage(
                      image: AssetImage('lib/images/background.png'),
                      fit:BoxFit.cover,
                    ),
                  ), 

      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
            
                // logo
                Positioned(
                        
                        
                        child: Padding(
                          padding: const EdgeInsets.all (6.0),
                          child: Image.asset(
                            'lib/images/logintaw.png',
                            width :150, 
                            height :150, 
                  
                          ),
                        ),
                  ),
            
                const SizedBox(height: 5),
            
                // Le'ts create an acount for you 
                Text(
                  'Let\'s create an account for you !',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),
                
                MyTextField(
                  controller: cinController,
                  hintText: 'CIN',
                  obscureText: false,
                ),   

                const SizedBox(height: 5),

                MyTextField(
                  controller: cnamController,
                  hintText: 'CNAM_Number',
                  obscureText: false,
                ),                
                const SizedBox(height: 5),
                // username textfield
                MyTextField(
                  controller:nameController,
                  hintText: 'Put your name',
                  obscureText: false,
                ),
                
                // Cnam_number textfield
                
                const SizedBox(height: 5),
                // username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Username@example.com',
                  obscureText: false,
                ),
            
                const SizedBox(height: 10),
            
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                
                // Confirmpassword textfield
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      phoneController.text = number.phoneNumber!; // Changed to phoneController
                    },
                    inputDecoration: InputDecoration(
                      hintText: 'Phone Number',
                    ),
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    errorMessage: 'Invalid phone number',
                    countrySelectorScrollControlled: true,
                    onSaved: (PhoneNumber? number) {
                      print('On Saved: $number');
                    },
                  ),
                  const SizedBox(height: 10),
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber number) {
                      phonefriendController.text = number.phoneNumber!; // Changed to phoneController
                    },
                    inputDecoration: InputDecoration(
                      hintText: 'Phone Your Friend Number',
                    ),
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: TextStyle(color: Colors.black),
                    formatInput: false,
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    errorMessage: 'Invalid phone number',
                    countrySelectorScrollControlled: true,
                    onSaved: (PhoneNumber? number) {
                      print('On Saved: $number');
                    },
                  ),
                const SizedBox(height:10),
                // forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                
            
                const SizedBox(height: 25),
            
                // sign in button
                MyButton(
                  text:"Sign Up",
                  onTap: signUserUp,
                ),
            
                
            
               
            
                // google + apple sign in buttons
                
            
                const SizedBox(height: 20),
            
                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap ,
                      child: const Text(
                        'Login now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      
      ),
    );
  }
  
}
