import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/form/custom_text_field.dart';
import 'package:urban_hunt/models/user_model.dart';
import 'package:urban_hunt/provider/user_provider.dart';
import 'package:urban_hunt/services/user_service.dart';
import 'package:urban_hunt/widget/custom_button.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final UserService _userService = UserService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _loading = false;

  void _onSubmit() async {
    try {
      if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please enter a valid name and phone number.'),
          ),
        );

        return;
      }

      setState(() => _loading = true);

      await _userService.updateProfile(
        _nameController.text,
        _phoneController.text,
      );

      if (!mounted) return;

      UserModel? user = context.read<UserProvider>().user;

      if (user == null) return;

      user = user.copyWith(
        name: _nameController.text,
        phone: _phoneController.text,
      );

      context.read<UserProvider>().setUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully.'),
          backgroundColor: Colors.greenAccent,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Something went wrong. Try again.')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();

    UserModel? user = context.read<UserProvider>().user;

    if (user == null) return;

    _nameController.text = user.name;
    _phoneController.text = user.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Edit Profile')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              CustomTextField(
                label: 'Name',
                controller: _nameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              CustomTextField(
                label: 'Phone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.done,
              ),
              const Spacer(),
              CustomButton(text: 'Save', loading: _loading, onTap: _onSubmit),
            ],
          ),
        ),
      ),
    );
  }
}
