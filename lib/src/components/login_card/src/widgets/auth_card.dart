import 'dart:math';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sailor/sailor.dart';
import 'package:sehool/src/screens/home/home.dart';
import 'package:supercharged/supercharged.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'package:validators/validators.dart';

import '../../../../../generated/l10n.dart';
import '../../../../../init_injectable.dart';
import '../../../../cubits/settings_cubit/settings_cubit.dart';
import '../../../../data/user_datasource.dart';
import '../../../../helpers/helper.dart';
import '../../../../models/form_data_model.dart';
import '../../../../routes/config_routes.dart';
import '../../../../screens/splash.dart';
import '../constants.dart';
import '../dart_helper.dart';
import '../matrix.dart';
import '../models/login_data.dart';
import '../paddings.dart';
import '../providers/auth.dart';
import 'animated_button.dart';
import 'animated_text.dart';
import 'animated_text_form_field.dart';
import 'custom_page_transformer.dart';
import 'expandable_container.dart';
import 'fade_in.dart';

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
    this.padding = const EdgeInsets.all(0),
    this.loadingController,
    this.emailValidator,
    this.passwordValidator,
    this.onSubmit,
    this.signupFields,
    this.onSubmitCompleted,
  }) : super(key: key);

  final EdgeInsets padding;
  final List<Widget> signupFields;
  final AnimationController loadingController;
  final FormFieldValidator<String> emailValidator;
  final FormFieldValidator<String> passwordValidator;
  final Function onSubmit;
  final Function onSubmitCompleted;

  @override
  AuthCardState createState() => AuthCardState();
}

class AuthCardState extends State<AuthCard> with TickerProviderStateMixin {
  final GlobalKey _cardKey = GlobalKey();

  var _isLoadingFirstTime = true;
  var _pageIndex = 0;
  static const cardSizeScaleEnd = .2;

  TransformerPageController _pageController;
  AnimationController _formLoadingController;
  AnimationController _routeTransitionController;
  Animation<double> _flipAnimation;
  Animation<double> _cardSizeAnimation;
  Animation<double> _cardSize2AnimationX;
  Animation<double> _cardSize2AnimationY;
  Animation<double> _cardRotationAnimation;
  Animation<double> _cardOverlayHeightFactorAnimation;
  Animation<double> _cardOverlaySizeAndOpacityAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = TransformerPageController();

    widget.loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _isLoadingFirstTime = false;
        _formLoadingController.forward();
      }
    });

    _flipAnimation = Tween<double>(begin: pi / 2, end: 0).animate(
      CurvedAnimation(
        parent: widget.loadingController,
        curve: Curves.easeOutBack,
        reverseCurve: Curves.easeIn,
      ),
    );

    _formLoadingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
      reverseDuration: const Duration(milliseconds: 300),
    );

    _routeTransitionController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _cardSizeAnimation = Tween<double>(begin: 1.0, end: cardSizeScaleEnd).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(0, .27272727, curve: Curves.easeInOutCirc),
    ));

    _cardOverlayHeightFactorAnimation = Tween<double>(begin: double.minPositive, end: 1.0).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.27272727, .5),
    ));
    _cardOverlaySizeAndOpacityAnimation = Tween<double>(begin: 1.0, end: 0).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.5, .72727272, curve: Curves.easeInOut),
    ));
    _cardSize2AnimationX = Tween<double>(begin: 1, end: 1).animate(_routeTransitionController);
    _cardSize2AnimationY = Tween<double>(begin: 1, end: 1).animate(_routeTransitionController);
    _cardRotationAnimation = Tween<double>(begin: 0, end: pi / 2).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.72727272, 1, curve: Curves.easeInOutCubic),
    ));
  }

  @override
  void dispose() {
    super.dispose();

    _formLoadingController.dispose();
    _pageController.dispose();
    _routeTransitionController.dispose();
  }

  void _switchRecovery(bool recovery) {
    final auth = Provider.of<Auth>(context, listen: false);

    auth.isRecover = recovery;
    if (recovery) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
      _pageIndex = 1;
    } else {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 1000),
        curve: Curves.easeInOut,
      );
      _pageIndex = 0;
    }
  }

  Future<void> runLoadingAnimation() {
    if (widget.loadingController.isDismissed) {
      return widget.loadingController.forward().then((_) {
        if (!_isLoadingFirstTime) {
          _formLoadingController.forward();
        }
      });
    } else if (widget.loadingController.isCompleted) {
      return _formLoadingController.reverse().then((_) => widget.loadingController.reverse());
    }
    return Future(() => null);
  }

  Future<void> _forwardChangeRouteAnimation() {
    final isLogin = Provider.of<Auth>(context, listen: false).isLogin;
    final deviceSize = MediaQuery.of(context).size;
    final cardSize = Helpers.getWidgetSize(_cardKey);

    final widthRatio = deviceSize.width / cardSize.height + (isLogin ? .25 : .65);
    final heightRatio = deviceSize.height / cardSize.width + .25;

    _cardSize2AnimationX = Tween<double>(begin: 1.0, end: heightRatio / cardSizeScaleEnd).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.72727272, 1, curve: Curves.easeInOutCubic),
    ));
    _cardSize2AnimationY = Tween<double>(begin: 1.0, end: widthRatio / cardSizeScaleEnd).animate(CurvedAnimation(
      parent: _routeTransitionController,
      curve: const Interval(.72727272, 1, curve: Curves.easeInOutCubic),
    ));

    widget?.onSubmit();

    return _formLoadingController.reverse().then((_) => _routeTransitionController.forward());
  }

  void _reverseChangeRouteAnimation() {
    _routeTransitionController.reverse().then((_) => _formLoadingController.forward());
  }

  void runChangeRouteAnimation() {
    if (_routeTransitionController.isCompleted) {
      _reverseChangeRouteAnimation();
    } else if (_routeTransitionController.isDismissed) {
      _forwardChangeRouteAnimation();
    }
  }

  void runChangePageAnimation() {
    final auth = Provider.of<Auth>(context, listen: false);
    _switchRecovery(!auth.isRecover);
  }

  Widget _buildLoadingAnimator({Widget child, ThemeData theme}) {
    Widget card;
    Widget overlay;

    card = AnimatedBuilder(
      animation: _flipAnimation,
      builder: (context, child) => Transform(
        transform: Matrix.perspective()..rotateX(_flipAnimation.value),
        alignment: Alignment.center,
        child: child,
      ),
      child: child,
    );

    overlay = Padding(
      padding: theme.cardTheme.margin,
      child: AnimatedBuilder(
        animation: _cardOverlayHeightFactorAnimation,
        builder: (context, child) => ClipPath.shape(
          shape: theme.cardTheme.shape,
          child: FractionallySizedBox(
            heightFactor: _cardOverlayHeightFactorAnimation.value,
            alignment: Alignment.topCenter,
            child: child,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(color: theme.accentColor),
        ),
      ),
    );

    overlay = ScaleTransition(
      scale: _cardOverlaySizeAndOpacityAnimation,
      child: FadeTransition(
        opacity: _cardOverlaySizeAndOpacityAnimation,
        child: overlay,
      ),
    );

    return Stack(
      children: <Widget>[
        card,
        Positioned.fill(child: overlay),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    final Widget current = Container(
      height: deviceSize.height,
      width: deviceSize.width,
      padding: widget.padding,
      child: TransformerPageView(
        physics: const NeverScrollableScrollPhysics(),
        pageController: _pageController,
        itemCount: 2,
        curve: Curves.easeInOut,
        index: _pageIndex,
        transformer: CustomPageTransformer(),
        itemBuilder: (BuildContext context, int index) {
          final child = (index == 0)
              ? _buildLoadingAnimator(
                  theme: theme,
                  child: _LoginCard(
                    key: _cardKey,
                    signupFields: widget.signupFields,
                    loadingController: _isLoadingFirstTime ? _formLoadingController : (_formLoadingController..value = 1.0),
                    emailValidator: widget.emailValidator,
                    passwordValidator: widget.passwordValidator,
                    onSwitchRecoveryPassword: () => _switchRecovery(true),
                    onSubmitCompleted: () {
                      _forwardChangeRouteAnimation().then((_) {
                        widget?.onSubmitCompleted();
                      });
                    },
                  ),
                )
              : _RecoverCard(
                  emailValidator: widget.emailValidator,
                  onSwitchLogin: () => _switchRecovery(false),
                );

          return Align(
            alignment: Alignment.topCenter,
            child: child,
          );
        },
      ),
    );

    return AnimatedBuilder(
      animation: _cardSize2AnimationX,
      builder: (context, snapshot) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(_cardRotationAnimation.value)
            ..scale(_cardSizeAnimation.value, _cardSizeAnimation.value)
            ..scale(_cardSize2AnimationX.value, _cardSize2AnimationY.value),
          child: current,
        );
      },
    );
  }
}

class _LoginCard extends StatefulWidget {
  const _LoginCard({
    Key key,
    this.loadingController,
    this.signupFields,
    @required this.emailValidator,
    @required this.passwordValidator,
    @required this.onSwitchRecoveryPassword,
    this.onSwitchAuth,
    this.onSubmitCompleted,
  }) : super(key: key);

  final AnimationController loadingController;
  final FormFieldValidator<String> emailValidator;
  final FormFieldValidator<String> passwordValidator;
  final Function onSwitchRecoveryPassword;
  final Function onSwitchAuth;
  final Function onSubmitCompleted;
  final List<Widget> signupFields;

  @override
  _LoginCardState createState() => _LoginCardState();
}

class _LoginCardState extends State<_LoginCard> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  TextEditingController _nameController;
  TextEditingController _passController;

  var _isLoading = false;
  var _isSubmitting = false;
  var _showShadow = true;

  AnimationController _loadingController;
  AnimationController _switchAuthController;
  AnimationController _postSwitchAuthController;
  AnimationController _submitController;

  Interval _nameTextFieldLoadingAnimationInterval;
  Interval _passTextFieldLoadingAnimationInterval;
  Interval _textButtonLoadingAnimationInterval;
  Animation<double> _buttonScaleAnimation;

  bool get buttonEnabled => !_isLoading && !_isSubmitting;

  SettingsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = getIt<SettingsCubit>();

    final auth = Provider.of<Auth>(context, listen: false);
    String _email, _password;
    if (getIt<IUserLocalDataSource>().readCredentials() != null) {
      _email = getIt<IUserLocalDataSource>().readCredentials()['email'];
      _password = getIt<IUserLocalDataSource>().readCredentials()['password'];
    }
    _nameController = TextEditingController(text: _email ?? auth.email);
    _passController = TextEditingController(text: _password ?? auth.password);

    _loadingController = widget.loadingController ??
        (AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 1150),
          reverseDuration: const Duration(milliseconds: 300),
        )..value = 1.0);

    _loadingController?.addStatusListener(handleLoadingAnimationStatus);

    _switchAuthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _postSwitchAuthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _submitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _nameTextFieldLoadingAnimationInterval = const Interval(0, .85);
    _passTextFieldLoadingAnimationInterval = const Interval(.15, 1.0);
    _textButtonLoadingAnimationInterval = const Interval(.6, 1.0, curve: Curves.easeOut);
    _buttonScaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _loadingController,
      curve: const Interval(.4, 1.0, curve: Curves.easeOutBack),
    ));
  }

  void handleLoadingAnimationStatus(AnimationStatus status) {
    if (status == AnimationStatus.forward) {
      setState(() => _isLoading = true);
    }
    if (status == AnimationStatus.completed) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();

    _loadingController?.removeStatusListener(handleLoadingAnimationStatus);
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

    _switchAuthController.dispose();
    _postSwitchAuthController.dispose();
    _submitController.dispose();
  }

  void _switchAuthMode() {
    final auth = Provider.of<Auth>(context, listen: false);
    final newAuthMode = auth.switchAuth();

    if (newAuthMode == AuthMode.signup) {
      _switchAuthController.forward();
    } else {
      _switchAuthController.reverse();
    }
  }

  Future<bool> _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (!_formKey.currentState.validate()) {
      return false;
    }

    _formKey.currentState.save();
    _submitController.forward();
    setState(() => _isSubmitting = true);
    final auth = Provider.of<Auth>(context, listen: false);
    String error;

    if (auth.isLogin) {
      error = await auth.onLogin(LoginData(
        name: auth.email,
        password: auth.password,
      ));
    } else {
      error = await auth.onSignup(LoginData(
        name: auth.email,
        password: auth.password,
      ));
    }

    Future.delayed(const Duration(milliseconds: 270), () {
      setState(() => _showShadow = false);
    });

    _submitController.reverse();

    if (!DartHelper.isNullOrEmpty(error)) {
      Helpers.showErrorOverlay(context, error: error);

      Future.delayed(const Duration(milliseconds: 271), () {
        setState(() => _showShadow = true);
      });
      setState(() => _isSubmitting = false);
      return false;
    }

    widget?.onSubmitCompleted();

    return true;
  }

  Widget _buildNameField(double width, Auth auth) {
    return AnimatedTextFormField(
      controller: _nameController,
      width: width,
      loadingController: _loadingController,
      interval: _nameTextFieldLoadingAnimationInterval,
      labelText: S.current.email,
      prefixIcon: const Icon(FluentIcons.person_accounts_24_regular),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
      validator: (value) {
        if (!isEmail(value)) return S.current.should_be_a_valid_email;
        return null;
      },
      onSaved: (value) => auth.email = value,
    );
  }

  Widget _buildPasswordField(double width, Auth auth) {
    return AnimatedPasswordTextFormField(
      animatedWidth: width,
      loadingController: _loadingController,
      interval: _passTextFieldLoadingAnimationInterval,
      labelText: S.current.password,
      controller: _passController,
      textInputAction: auth.isLogin ? TextInputAction.done : TextInputAction.next,
      focusNode: _passwordFocusNode,
      onFieldSubmitted: (value) {
        if (auth.isLogin) {
          _submit();
        }
      },
      validator: Validators.longStringValidator,
      onSaved: (value) => auth.password = value,
    );
  }

  Widget _buildForgotPassword(ThemeData theme) {
    return FadeIn(
      controller: _loadingController,
      fadeDirection: FadeDirection.bottomToTop,
      offset: .5,
      curve: _textButtonLoadingAnimationInterval,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
        ),
        onPressed: buttonEnabled
            ? () {
                _formKey.currentState.save();
                widget.onSwitchRecoveryPassword();
              }
            : null,
        child: Text(
          S.current.i_forgot_password,
          style: theme.textTheme.bodyText2,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(ThemeData theme, Auth auth) {
    return ScaleTransition(
      scale: _buttonScaleAnimation,
      child: AnimatedButton(
        controller: _submitController,
        text: auth.isLogin ? S.current.login : S.current.register,
        onPressed: _submit,
      ),
    );
  }

  Widget _buildSwitchAuthButton(ThemeData theme, Auth auth) {
    return FadeIn(
      controller: _loadingController,
      offset: .5,
      curve: _textButtonLoadingAnimationInterval,
      fadeDirection: FadeDirection.topToBottom,
      child: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10), textStyle: Theme.of(context).textTheme.button.copyWith(color: theme.primaryColor)),
        onPressed: buttonEnabled ? _switchAuthMode : null,
        child: AnimatedText(
          text: auth.isSignup ? S.current.login : S.current.register,
          textRotation: AnimatedTextRotation.down,
        ),
      ),
    );
  }

  Widget _buildGustButton(ThemeData theme, Auth auth) {
    return FadeIn(
      controller: _loadingController,
      offset: .5,
      curve: _textButtonLoadingAnimationInterval,
      fadeDirection: FadeDirection.topToBottom,
      child: TextButton(
        style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10), textStyle: Theme.of(context).textTheme.button.copyWith(color: theme.primaryColor)),
        onPressed: buttonEnabled ? () => AppRouter.sailor.navigate(HomeScreen.routeName) : null,
        child: AnimatedText(
          text: S.current.login_as_guest,
          textRotation: AnimatedTextRotation.down,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: true);
    final isLogin = auth.isLogin;
    final theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.95, 400.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;
    final authForm = Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          AnimatedOpacity(
            opacity: buttonEnabled ? 1 : 0,
            duration: 300.milliseconds,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Expanded(
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (!Helpers.isArabic(context)) const Text('عربي') else const Text('English'),
                        ],
                      ),
                      value: !Helpers.isArabic(context),
                      onChanged: (value) async {
                        if (value) {
                          await cubit.setLanguageCode('en');
                        } else {
                          await cubit.setLanguageCode('ar');
                        }
                        AppRouter.sailor.navigate(
                          SplashScreen.routeName,
                          navigationType: NavigationType.pushAndRemoveUntil,
                          removeUntilPredicate: (_) => false,
                        );
                      },
                    ),
                  ),
                  const Icon(FontAwesomeIcons.globe),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: cardPadding,
              right: cardPadding,
              top: cardPadding + 10,
            ),
            width: cardWidth,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildNameField(textFieldWidth, auth),
                const SizedBox(height: 20),
                _buildPasswordField(textFieldWidth, auth),
                const SizedBox(height: 10),
                AnimatedOpacity(
                  opacity: buttonEnabled ? 1 : 0,
                  duration: 300.milliseconds,
                  child: Row(
                    children: [
                      Switch(
                        value: rememberMe,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value;
                          });
                        },
                      ),
                      Text(S.current.remember_me),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          ExpandableContainer(
            backgroundColor: theme.accentColor,
            controller: _switchAuthController,
            initialState: isLogin ? ExpandableContainerState.shrunk : ExpandableContainerState.expanded,
            alignment: Alignment.topLeft,
            color: theme.cardTheme.color,
            width: cardWidth,
            padding: const EdgeInsets.symmetric(
              horizontal: cardPadding,
              vertical: 10,
            ),
            onExpandCompleted: () => _postSwitchAuthController.forward(),
            child: isLogin
                ? const SizedBox(
                    height: cardPadding,
                  )
                : Column(
                    children: widget.signupFields,
                  ),
          ),
          Container(
            padding: Paddings.fromRBL(cardPadding),
            width: cardWidth,
            child: Column(
              children: <Widget>[
                _buildForgotPassword(theme),
                const SizedBox(height: 10),
                _buildSubmitButton(theme, auth),
                const SizedBox(height: 10),
                _buildGustButton(theme, auth),
                const SizedBox(height: 10),
                _buildSwitchAuthButton(theme, auth),
              ],
            ),
          ),
        ],
      ),
    );

    return Card(
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(horizontal: deviceSize.width * .1),
      elevation: _showShadow ? theme.cardTheme.elevation : 0,
      child: SingleChildScrollView(physics: const BouncingScrollPhysics(), child: authForm),
    );
  }
}

class _RecoverCard extends StatefulWidget {
  const _RecoverCard({
    Key key,
    @required this.emailValidator,
    @required this.onSwitchLogin,
  }) : super(key: key);

  final FormFieldValidator<String> emailValidator;
  final Function onSwitchLogin;

  @override
  _RecoverCardState createState() => _RecoverCardState();
}

class _RecoverCardState extends State<_RecoverCard> with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formRecoverKey = GlobalKey();

  TextEditingController _nameController;

  var _isSubmitting = false;

  AnimationController _submitController;

  @override
  void initState() {
    super.initState();

    final auth = Provider.of<Auth>(context, listen: false);
    _nameController = TextEditingController(text: auth.email);

    _submitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _submitController.dispose();
  }

  Future<bool> _submit() async {
    if (!_formRecoverKey.currentState.validate()) {
      return false;
    }
    final auth = Provider.of<Auth>(context, listen: false);

    _formRecoverKey.currentState.save();
    _submitController.forward();
    setState(() => _isSubmitting = true);
    final error = await auth.onRecoverPassword(auth.email);

    if (error != null) {
      Helpers.showErrorOverlay(context, error: error);

      setState(() => _isSubmitting = false);
      _submitController.reverse();
      return false;
    } else {
      Helpers.showSuccessOverlay(
        context,
        message: '''
${S.current.the_code_has_been_sent_to}
${auth.email}''',
      );

      setState(() => _isSubmitting = false);
      _submitController.reverse();
      widget.onSwitchLogin();
      return true;
    }
  }

  Widget _buildRecoverNameField(double width, Auth auth) {
    return AnimatedTextFormField(
      controller: _nameController,
      width: width,
      labelText: S.current.email,
      prefixIcon: const Icon(FluentIcons.person_accounts_24_regular),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (value) => _submit(),
      validator: widget.emailValidator,
      onSaved: (value) => auth.email = value,
    );
  }

  Widget _buildRecoverButton(ThemeData theme) {
    return AnimatedButton(
      controller: _submitController,
      text: S.current.send,
      onPressed: !_isSubmitting ? _submit : null,
    );
  }

  Widget _buildBackButton(ThemeData theme) {
    return TextButton(
      onPressed: !_isSubmitting
          ? () {
              _formRecoverKey.currentState.save();
              widget.onSwitchLogin();
            }
          : null,
      style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10), textStyle: Theme.of(context).textTheme.button.copyWith(color: theme.primaryColor)),
      child: Text(S.current.back),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final auth = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    final cardWidth = min(deviceSize.width * 0.75, 360.0);
    const cardPadding = 16.0;
    final textFieldWidth = cardWidth - cardPadding * 2;

    return FittedBox(
        child: Card(
      child: Container(
        padding: const EdgeInsets.only(
          left: cardPadding,
          top: cardPadding + 10.0,
          right: cardPadding,
          bottom: cardPadding,
        ),
        width: cardWidth,
        alignment: Alignment.center,
        child: Form(
          key: _formRecoverKey,
          child: Column(
            children: [
              Text(
                S.current.recoverPasswordIntro,
                key: kRecoverPasswordIntroKey,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText2,
              ),
              const SizedBox(height: 20),
              _buildRecoverNameField(textFieldWidth, auth),
              const SizedBox(height: 20),
              Text(
                S.current.recoverPasswordDescription,
                key: kRecoverPasswordDescriptionKey,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText2,
              ),
              const SizedBox(height: 10),
              _buildRecoverButton(theme),
              const SizedBox(height: 10),
              _buildBackButton(theme),
            ],
          ),
        ),
      ),
    ));
  }
}
