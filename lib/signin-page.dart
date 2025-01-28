import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:keycloak_wrapper/keycloak_wrapper.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  FlutterAppAuth appAuth = FlutterAppAuth();
  final String _clientId = 'prescricao-app';
  final String _redirectUrl = 'com.exemplo.base_app';
  final String _issuer = 'https://auth-hom.cfm.org.br/realms/CFM';
  final String authorizationEndpoint =
      'https://auth-hom.cfm.org.br/realms/CFM/protocol/openid-connect/auth';
  final String tokenEndpoint =
      'https://auth-hom.cfm.org.br/realms/CFM/protocol/openid-connect/token';
  final String endSessionEndpoint =
      'https://auth-hom.cfm.org.br/realms/CFM/protocol/openid-connect/logout';
  final List<String> _scopes = <String>[
    'openid',
    'profile',
    'email',
  ];
  openIdConnect(
      {ExternalUserAgent externalUserAgent =
          ExternalUserAgent.asWebAuthenticationSession}) async {
    try {
      final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(_clientId, _redirectUrl,
            serviceConfiguration: AuthorizationServiceConfiguration(
              authorizationEndpoint: authorizationEndpoint,
              tokenEndpoint: tokenEndpoint,
              endSessionEndpoint: endSessionEndpoint,
            ),
            scopes: _scopes,
            externalUserAgent: externalUserAgent),
      );
      print('SUCCESSSSSSSSSSS');
      print(result);
    } catch (e) {
      print('erro no openid connect try catch: $e');
    }
  }

  void _onSignOnPressed() async {
    openIdConnect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Imagem centralizada e redonda
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Image.asset('assets/logos/cfm-logo2.png')),
            // Botão Sign-On
            ElevatedButton(
              onPressed: _onSignOnPressed,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 70, vertical: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
              ),
              child: Text('Sign-in', style: TextStyle(fontSize: 20)),
            ),

            // Texto centralizado
            Text(
              'POC - Super App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}



// final keycloakConfig = KeycloakConfig(
    //   bundleIdentifier: 'POC',
    //   clientId: 'prescricao-app',
    //   frontendUrl: 'https://prescricao-hom.cfm.org.br/login',
    //   realm: 'CFM',
    // );

    // final keycloakWrapper = KeycloakWrapper(config: keycloakConfig);

    // // WidgetsFlutterBinding.ensureInitialized();
    // keycloakWrapper.initialize();

    // keycloakWrapper.onError = (message, _, __) {
    //   // Display the error message inside a snackbar.
    //   scaffoldMessengerKey.currentState
    //     ?..hideCurrentSnackBar()
    //     ..showSnackBar(SnackBar(content: Text(message)));
    // };