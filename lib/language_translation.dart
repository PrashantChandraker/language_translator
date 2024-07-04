import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslationPage extends StatefulWidget {
  const LanguageTranslationPage({super.key});

  @override
  State<LanguageTranslationPage> createState() =>
      _LanguageTranslationPageState();
}

var languages = ['Hindi', 'English', 'Marathi', 'Telugu'];
var originLanguage = 'From';
var destinationLanguage = 'To';
var output = '';
TextEditingController languageController = TextEditingController();

class _LanguageTranslationPageState extends State<LanguageTranslationPage> {
  void translate(String src, String dest, String input) async {
    GoogleTranslator translator = new GoogleTranslator();
    var translation = await translator.translate(input, from: src, to: dest);
    setState(() {
      output = translation.text.toString();
    });

    if (src == '--' || dest == '--') {
      setState(() {
        output = 'Failed to translate';
      });
    }
  }

  String getLanguageCode(String language) {
    if (language == 'English') {
      return 'en';
    } else if (language == 'Hindi') {
      return 'hi';
    } else if (language == 'Marathi') {
      return 'mr';
    } else if (language == 'Telugu') {
      return 'te';
    }
    return '__';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 185, 151),
      appBar: AppBar(
          title: const Text(
            'LANGUAGE  TRANSLATOR',
            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(85, 0, 255, 208),
          elevation: 0),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      originLanguage,
                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold ),
                    ),
                    dropdownColor: Colors.black,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        originLanguage = value!;
                      });
                    },
                  ),
                  const SizedBox(width: 40),
                  const Icon(Icons.arrow_right_alt_outlined,
                      color: Color.fromARGB(255, 4, 4, 160), size: 40),
                  const SizedBox(width: 40),
                  DropdownButton(
                    focusColor: Colors.white,
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.white,
                    hint: Text(
                      destinationLanguage,
                      style: const TextStyle( color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    dropdownColor: Colors.black,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languages.map((String dropDownStringItem) {
                      return DropdownMenuItem(
                        value: dropDownStringItem,
                        child: Text(dropDownStringItem),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        destinationLanguage = value!;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  cursorColor: Colors.white,
                  autofocus: false,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                      labelText: 'Please enter your text...',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                      )),
                  controller: languageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text to translate;';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                        translate(
                            getLanguageCode(originLanguage),
                            getLanguageCode(destinationLanguage),
                            languageController.text.toString());
                      },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      height: 50,
                      width: 130,
                      child: Center(child: Text('Translate', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),)),
                      
                    )
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '\n$output',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}