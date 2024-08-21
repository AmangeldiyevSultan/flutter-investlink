/// Server url.
enum Url {
  /// Dev url.
  dev('https://app-alp-sb1.investlink.io'),

  /// Prod url.
  prod('https://app-alp-sb1.investlink.io');

  const Url(this.value);

  /// Url value.
  final String value;
}
