import 'package:clean_architecture_mvvm/application/app_preferences.dart';
import 'package:clean_architecture_mvvm/application/dependency_injection.dart';
import 'package:clean_architecture_mvvm/presentation/common/state_renderer/state_renderer_implementation.dart';
import 'package:clean_architecture_mvvm/presentation/login/view_model/login_view_model.dart';
import 'package:clean_architecture_mvvm/presentation/resources/assets_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/colors_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/routes_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/strings_manager.dart';
import 'package:clean_architecture_mvvm/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginViewModel _loginViewModel = instance<LoginViewModel>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _bind();
  }

  void _bind() {
    _loginViewModel.start();
    _nameController.addListener(
      () => _loginViewModel.setName(_nameController.text),
    );
    _passwordController.addListener(
      () => _loginViewModel.setPassword(_passwordController.text),
    );
    _loginViewModel.isLoggedInStreamController.stream.listen((
      isLoggedIn,
    ) async {
      if (isLoggedIn) {
        await _appPreferences.setLoggedIn(true);
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            Navigator.pushReplacementNamed(context, RoutesManager.mainRoute);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _loginViewModel.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      body: StreamBuilder<FlowState>(
        stream: _loginViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreen(
                context,
                () => _loginViewModel.login(),
                _getContent(),
              ) ??
              _getContent();
        },
      ),
    );
  }

  Widget _getContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ValuesManager.padding24,
            vertical: ValuesManager.padding32,
          ),
          color: ColorsManager.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AssetsManager.splashLogo),
                const SizedBox(height: ValuesManager.padding24),
                StreamBuilder<bool>(
                  stream: _loginViewModel.isNameValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: StringsManager.userName,
                        labelText: StringsManager.userName,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringsManager.userNameError,
                      ),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding24),
                StreamBuilder<bool>(
                  stream: _loginViewModel.isPasswordValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: StringsManager.password,
                        labelText: StringsManager.password,
                        errorText: (snapshot.data ?? true)
                            ? null
                            : StringsManager.passwordError,
                      ),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding32),
                StreamBuilder<bool>(
                  stream: _loginViewModel.areAllInputsValid,
                  builder: (context, snapshot) {
                    return ElevatedButton(
                      onPressed: (snapshot.data ?? false)
                          ? () {
                              _loginViewModel.login();
                            }
                          : null,
                      child: const Text(StringsManager.login),
                    );
                  },
                ),
                const SizedBox(height: ValuesManager.padding32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          RoutesManager.forgotPasswordRoute,
                        ),
                        child: const Text(StringsManager.forgotPassword),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          RoutesManager.registerRoute,
                        ),
                        child: const Text(StringsManager.registerText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
