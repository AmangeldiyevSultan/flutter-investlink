import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:investlink/src/core/assets/colors/color_scheme.dart';
import 'package:investlink/src/core/assets/media_res/svg.dart';
import 'package:investlink/src/core/assets/text/text_extension.dart';
import 'package:investlink/src/core/common/utils/logger/logger.dart';
import 'package:investlink/src/features/auth/di/auth_scope.dart';
import 'package:investlink/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:investlink/src/features/auth/presentation/widgets/auth_appbar.dart';
import 'package:investlink/src/l10n/app_localizations_x.dart';
import 'package:investlink/src/uikit/buttons/custom_elevated_button.dart';
import 'package:investlink/src/uikit/buttons/custom_text_button.dart';
import 'package:investlink/src/uikit/loader/stack_loader.dart';
import 'package:investlink/src/uikit/text/default_text.dart';
import 'package:investlink/src/uikit/textfield/custom_text_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _emailTextController;
  late final TextEditingController _passwordTextController;
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  late final AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();

    _authBloc = context.read<IAuthScope>().authBloc;
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, authState) {
        authState.whenOrNull(
          idle: (authResult, error) {
            if (error == null) {}
          },
        );
      },
      builder: (context, authState) {
        return LoadingStack(
          isLoading: authState.isProcessing,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const AuthAppbar(),
            body: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Gap(10),

                        /// Login Text
                        DText(
                          context.l10n.login,
                          style: AppTextTheme.of(context).medium26,
                        ),
                        const Gap(30),

                        /// TextField Form for Email and Password
                        _AuthTextFields(
                          emailTextController: _emailTextController,
                          passwordTextController: _passwordTextController,
                          passwordVisible: _passwordVisible,
                          formKey: _formKey,
                          onObscureTextPressed: () => setState(() {
                            _passwordVisible = !_passwordVisible;
                          }),
                        ),

                        const Gap(40),

                        /// Forger Password Text Button
                        CtmTextButton(
                          onPressed: () {},
                          child: DText(
                            context.l10n.forgetPassword,
                            style: AppTextTheme.of(context)
                                .regular18
                                .copyWith(color: AppColorScheme.of(context).textBlue),
                          ),
                        ),
                        const Gap(40),
                        SvgPicture.asset(SvgRes.line),
                        const Gap(40),

                        /// No Account or Registration TextButton
                        _NoAccountOrRegistrationRichText(() {}),
                        const Gap(40),

                        /// Privacy Policy TextButton
                        _PrivacyPolicyRichText(() {}),
                      ],
                    ),
                  ),
                  const Spacer(),

                  /// Container Model for Sign In
                  _ContainerModelForSignIn(_signInOnPressed),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _signInOnPressed() {
    if (_formKey.currentState!.validate()) {
      logger
        ..info('Login with email or name: ${_emailTextController.text}')
        ..info('Login with password: ${_passwordTextController.text}');

      _authBloc.add(
        AuthEvent.signIn(
          email: _emailTextController.text.trim(),
          password: _passwordTextController.text.trim(),
        ),
      );
    }
  }
}

class _ContainerModelForSignIn extends StatelessWidget {
  const _ContainerModelForSignIn(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 113,
      decoration: BoxDecoration(
        color: AppColorScheme.of(context).textFieldBackground,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: CtmElevatedButton(
            onPressed: onPressed,
            text: context.l10n.signIn,
          ),
        ),
      ),
    );
  }
}

class _AuthTextFields extends StatelessWidget {
  const _AuthTextFields({
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    required bool passwordVisible,
    required GlobalKey<FormState> formKey,
    required VoidCallback onObscureTextPressed,
  })  : _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _passwordVisible = passwordVisible,
        _formKey = formKey,
        _onObscureTextPressed = onObscureTextPressed;

  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final bool _passwordVisible;
  final GlobalKey<FormState> _formKey;
  final VoidCallback _onObscureTextPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CtmTextField(
            controller: _emailTextController,
            labelText: context.l10n.email,
          ),
          const Gap(20),
          CtmTextField(
            controller: _passwordTextController,
            labelText: context.l10n.password,
            keyboardType: TextInputType.visiblePassword,
            obscureText: !_passwordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: AppColorScheme.of(context).defaultTextColor,
              ),
              onPressed: _onObscureTextPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoAccountOrRegistrationRichText extends StatelessWidget {
  const _NoAccountOrRegistrationRichText(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CtmTextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: context.l10n.noAccount,
              style: AppTextTheme.of(context)
                  .regular18
                  .copyWith(color: AppColorScheme.of(context).defaultTextColor),
            ),
            TextSpan(
              text: ' ${context.l10n.registration}',
              style: AppTextTheme.of(context)
                  .regular18
                  .copyWith(color: AppColorScheme.of(context).textBlue),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivacyPolicyRichText extends StatelessWidget {
  const _PrivacyPolicyRichText(this.onPressed);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CtmTextButton(
      onPressed: onPressed,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '${context.l10n.usingOurServUAgree}\n',
              style: AppTextTheme.of(context)
                  .regular12
                  .copyWith(color: AppColorScheme.of(context).defaultTextColor),
            ),
            TextSpan(
              text: ' ${context.l10n.rules}',
              style: AppTextTheme.of(context)
                  .regular12
                  .copyWith(color: AppColorScheme.of(context).textBlue),
            ),
            TextSpan(
              text: ' ${context.l10n.and}',
              style: AppTextTheme.of(context)
                  .regular12
                  .copyWith(color: AppColorScheme.of(context).defaultTextColor),
            ),
            TextSpan(
              text: ' ${context.l10n.privacyPolicy}',
              style: AppTextTheme.of(context)
                  .regular12
                  .copyWith(color: AppColorScheme.of(context).textBlue),
            ),
          ],
        ),
      ),
    );
  }
}
