import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final formKey = GlobalKey<FormState>();
  final genderKey = GlobalKey<FormFieldState>();
  final dobKey = GlobalKey<FormFieldState>();
  String? fullName;
  final fullNameFocus = FocusNode();
  String? dropDownValue;
  String? savedDropDownValue;
  final genderFocus = FocusNode();
  final dobController = TextEditingController();
  String? dob;
  String? savedDob;
  final dobFocus = FocusNode();
  String? email;
  final emailFocus = FocusNode();
  String? phoneNumber;
  final phoneNumberFocus = FocusNode();
  final passwordController = TextEditingController();
  String? password;
  final passwordFocus = FocusNode();
  String? confirmPassword;
  final confirmPasswordFocus = FocusNode();
  bool? checked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Form Application",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
        ],
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
        elevation: 10,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: formKey,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(10, 10),
                      blurRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      validator: (value) {
                        value = value?.replaceAll("  ", " ");
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a name";
                        }
                        if (value.length < 3) {
                          return "Name must be at least 3 character long";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        fullName = newValue;
                      },
                      focusNode: fullNameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(genderFocus);
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField(
                      // key: genderKey,
                      decoration: InputDecoration(
                        labelText: "Select gender",
                        prefixIcon: Icon(Icons.menu),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      items: ["Male", "Female", "Other"].map((gender) {
                        return DropdownMenuItem(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropDownValue = value;
                        });
                        FocusScope.of(context).requestFocus(dobFocus);
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please select gender";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        savedDropDownValue = newValue;
                      },
                      focusNode: genderFocus,
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      // key: dobKey,
                      controller: dobController,
                      decoration: InputDecoration(
                        labelText: "Date of birth",
                        prefixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      readOnly: true,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2000, 1, 1),
                          firstDate: DateTime(1975),
                          lastDate: DateTime.now(),
                        );
                        if (picked != null) {
                          setState(() {
                            dob = DateFormat(
                              "EEEE, dd-MMM-yyyy",
                            ).format(picked);
                            dobController.text = dob!;
                          });
                        }
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please select date of birth";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        savedDob = newValue;
                      },
                      focusNode: dobFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Gmail",
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        value = value?.replaceAll(" ", "");
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a gmail";
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return "Please enter a valid gmail";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        email = newValue;
                      },
                      focusNode: emailFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(phoneNumberFocus);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        value = value?.replaceAll(" ", "");
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a phone number";
                        }
                        if (!RegExp(r'^[0-9]{10,}$').hasMatch(value)) {
                          return "Ph no: at least 10 number long (digits only)";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        phoneNumber = newValue;
                      },
                      focusNode: phoneNumberFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      obscureText: true,
                      validator: (value) {
                        value = value?.replaceAll(" ", "");
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter a password";
                        }
                        if (!RegExp(r'^(?=.*[A-Z]).+$').hasMatch(value)) {
                          return "Include uppercase";
                        }
                        if (!RegExp(r'^(?=.*[@$!%*?&]).+$').hasMatch(value)) {
                          return "Include special character";
                        }
                        if (!RegExp(
                          r'^[A-Za-z\d@$!%*?&]{8,}$',
                        ).hasMatch(value)) {
                          return "Password must be at least 8 characters";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        password = newValue;
                      },
                      focusNode: passwordFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(
                          context,
                        ).requestFocus(confirmPasswordFocus);
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirm password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
                      obscureText: true,
                      validator: (value) {
                        value = value?.replaceAll(" ", "");
                        if (value == null || value.trim().isEmpty) {
                          return "Please confirm the password";
                        }
                        if (value != passwordController.text) {
                          return "Password do not match";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        confirmPassword = newValue;
                      },
                      focusNode: confirmPasswordFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                          // genderKey.currentState!.reset();
                          // dobKey.currentState!.reset();
                          formKey.currentState!.reset();
                          setState(() {
                            dobController.clear;
                            passwordController.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Form submitted successfully"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.black, width: 3),
                      ),
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
