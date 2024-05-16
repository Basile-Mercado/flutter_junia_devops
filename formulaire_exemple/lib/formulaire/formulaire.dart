import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:formulaire_exemple/formulaire/politics.dart';

class FormulairePage extends StatefulWidget {
  const FormulairePage({super.key});

  @override
  State<FormulairePage> createState() => FormulairePageState();
}

class FormulairePageState extends State<FormulairePage> {
  late TextEditingController mail;
  late TextEditingController mdp;
  DateTime selectedDate = DateTime.now();
  bool isChecked = false;
  bool isEmailSubmitted = false;
  bool isPasswordSubmitted = false;
  List<DropdownMenuEntry> entry = const [
    DropdownMenuEntry(value: 0, label: "Homme"),
    DropdownMenuEntry(value: 1, label: "Femme"),
    DropdownMenuEntry(value: 2, label: "Autre"),
  ];
 bool isTap = false;

  @override
  void initState() {
    super.initState();
    mail = TextEditingController();
    mdp = TextEditingController();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? get errorMailText {
    final text = mail.text;
    if (text.isEmpty) {
      return "Ne peut pas être vide";
    }
    if (!text.contains('@')) {
      return "Ce n'est pas un mail";
    }
    // return null if the text is valid
    return null;
  }

  String? get errorMdpText {
    final text = mdp.text;
    if (text.isEmpty) {
      return 'Ne peut pas être vide';
    }
    if (text.length < 8) {
      return 'Le mot de passe est trop court';
    }
    if (text.length > 12) {
      return 'Le mot de passe est trop long';
    }
    return null;
  }

  bool isFormValid() {
    bool mdpLength = mdp.text.length < 8 && mdp.text.length > 12;
    bool mailCar = mail.text.contains('@');
    if (mdp.text.isEmpty && mail.text.isEmpty && mdpLength && mailCar) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulaire Exemple'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Email:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextField(
                  controller: mail,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Veuillez saisir votre email',
                    border: const OutlineInputBorder(),
                    errorText: isEmailSubmitted ? errorMailText : null,
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                  onTap: () => isEmailSubmitted = true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Mot de passe:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: TextField(
                  controller: mdp,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Veuillez saisir votre mot de passe',
                    errorText: isPasswordSubmitted ? errorMdpText : null,
                  ),
                  onChanged: (_) {
                    setState(() {});
                  },
                  onTap: () => isPasswordSubmitted = true,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Date de naissance:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              IconButton(
                onPressed: () => selectDate(context),
                icon: const Icon(Icons.date_range),
              ),
              DropdownMenu(
                dropdownMenuEntries: entry,
                initialSelection: 0,
                enableSearch: false,
                requestFocusOnTap: false,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isTap = !isTap;
                  });
                },
                child: Card(
                  color: isTap ? Colors.blue : Colors.green,
                  child: const SizedBox(
                    height: 100,
                    width: 300,
                    child: Text('Je change de couleur', style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "J'accepte les ",
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: 'conditions générales',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                showDialog(
                                  context: context,
                                  builder: (context) => const PoliticsDialog(),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                width: 500,
                child: ElevatedButton(
                    onPressed: () => isFormValid()
                        ? print('Formulaire vide')
                        : print('Formulaire envoyé'),
                    child: const Text("S'inscrire")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
