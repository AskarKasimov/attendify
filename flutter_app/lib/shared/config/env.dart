class Env {
  static const clientId = String.fromEnvironment('CLIENT_ID', defaultValue: '');
  static const redirectUrl = String.fromEnvironment(
    'REDIRECT_URL',
    defaultValue: '',
  );
  static const issuer = String.fromEnvironment('ISSUER', defaultValue: '');
}
