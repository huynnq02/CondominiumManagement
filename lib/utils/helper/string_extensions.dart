extension StringExtensions on String {
  bool isValidEmail() => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(this);

  bool isValidPhoneNumber() =>
      RegExp(r"^(?:[+84][0])?[0-9]{10,12}$").hasMatch(this);

  String formatDateTime() {
    final result = DateTime.parse(this);
    String day = result.day / 10 < 1
        ? "0" + result.day.toString()
        : result.day.toString();
    String month = result.month / 10 < 1
        ? "0" + result.month.toString()
        : result.month.toString();

    final formattedDate = "$day/$month/${result.year}";
    return formattedDate;
  }
}
