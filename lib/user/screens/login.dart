import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_phone_number_input/consts/enums.dart';
import 'package:extended_phone_number_input/phone_number_input.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user/user/screens/user_screen.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  List userlikeitems = [];
  var length;

  @override
  void initState() {
    setState(() {
      like();
    });
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var hei = MediaQuery.of(context).size.height;
    var wid = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: hei * 0.28,
                  width: wid * 0.6,
                  // child: Image.network(
                  //     'https://firebasestorage.googleapis.com/v0/b/ecommerce-c053d.appspot.com/o/WhatsApp_Image_2022-09-27_at_8.53.59_PM-removebg-preview%20(1).png?alt=media&token=51429f8f-3e08-401e-915b-d6c49ec401cb',
                  //     fit: BoxFit.fill),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Shopeaze",
                        style: GoogleFonts.readexPro(
                            color: Color.fromARGB(255, 79, 2, 172),
                            fontSize: wid * 0.08,
                            fontWeight: FontWeight.w600)),
                  ],
                ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Row(
                    children: [
                      Text("Enter Your Mobile.no",
                          style: GoogleFonts.poppins(
                              color: Color.fromARGB(255, 112, 112, 112),
                              fontSize: wid * 0.04,
                              fontWeight: FontWeight.w600))
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 30, right: 30, bottom: 15),
                  child: PhoneNumberInput(
                    initialCountry: 'IN',
                    hint: "Mobile number",
                    allowPickFromContacts: false,
                    errorText: "invalid mobile.no",
                    countryListMode: CountryListMode.dialog,
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    onChanged: (p0) {
                      setState(() => phone.text = p0.toString());
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: hei * 0.06,
                  width: wid * 0.8,
                  child: MaterialButton(
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                        } else {
                          use();
                        }
                      },
                      color: Colors.black,
                      child: Text("Login",
                          style: GoogleFonts.readexPro(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: wid * 0.04,
                              fontWeight: FontWeight.w500))),
                )
              ]),
        ),
      ),
    ));
  }

  use() {
    GetStorage getStorage = GetStorage();
    getStorage.write("mobile", phone.text).whenComplete(() =>
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: ((context) => user())),
            (route) => false));
    final_total();
  }

  final_total() async {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(GetStorage().read('mobile'))
        .set({'Total': '0'})
        .whenComplete(() => insert_like())
        .whenComplete(() => visit());
  }

  like() {
    FirebaseFirestore.instance
        .collection('products')
        .doc('+918148082690')
        .collection('products')
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {
              setState(() {
                userlikeitems.add(doc.data());
                length = data.docs.length;
              });
            }));
  }

  insert_like() {
    for (var i = 0; i < length; i++) {
      FirebaseFirestore.instance
          .collection('likes')
          .doc("+918148082690" + GetStorage().read('mobile'))
          .collection('likes')
          .doc(userlikeitems[i]['Product_name'])
          .set({'liked': 'no'});
    }
  }

  visit() {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc("+918148082690")
        .collection('visits')
        .doc(GetStorage().read('mobile'))
        .set({'mobile': GetStorage().read('mobile')});
  }
}
