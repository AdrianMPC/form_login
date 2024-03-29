import 'package:flutter/material.dart';
import 'package:form_login/presentation/utils/textfield.dart';
import 'package:go_router/go_router.dart';

const double separacion = 8;
const String regexDNI = r'^[0-9]{8}$';
const String pass = r'^abcde123$';
const String dniInvalido = 'Ingrese un DNI válido';
const String passInvalida = 'Ingrese una contraseña válida';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final controllerText = TextEditingController();
  final controllerText2 = TextEditingController();

  String? _validador(String? value, RegExp exp, String error, TextEditingController controller) {
    if(exp.hasMatch(value!)){
      return null;
    }
    controller.clear();
    return error;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormWrapper(
              controller: controllerText,
              titulo: 'DNI',
              hintTexto: 'Ingrese su DNI', 
              tipoTeclado: TextInputType.number,
              validador: (value) => _validador(value, RegExp(regexDNI), dniInvalido, controllerText),
            ),
            const SizedBox(height: separacion),
            TextFormWrapper(
              controller: controllerText2,
              titulo: 'Contraseña',
              hintTexto: 'Ingrese abcde123', 
              tipoTeclado: TextInputType.text,
              password: true,
              validador: (value) => _validador(value, RegExp(pass), passInvalida, controllerText2),
            ),
            const SizedBox(height: separacion),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Aquí nos conectamos con la base de datos o algo...')),
                    );
                    _formKey.currentState?.save();
                    context.go('/home/${controllerText.value.text}');
                  }
                },
                child: const Text('Mandar'),
              ),
            ),
          ],
      
        ),
      ),
    );
  }
}