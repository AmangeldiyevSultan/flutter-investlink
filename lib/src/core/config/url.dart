/// Server url.
enum Url {
  /// Dev url.
  dev('https://app1-eu-sw1.ivlk.io'),

  /// Prod url.
  prod('https://app1-eu-sw1.ivlk.io');

  const Url(this.value);

  /// Url value.
  final String value;
}
