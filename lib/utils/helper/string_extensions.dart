extension StringExtensions on String {
  bool isValidEmail() => RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
      .hasMatch(this);

  bool isValidPhoneNumber() {
    return RegExp(r"^(\+84|0)\d{9,13}$").hasMatch(this);
  }

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

  String standardlizeString() {
    var result = this;
    result = result.trim().replaceAll(RegExp(r"((?!\n)\s){2,}"), " ");
    // delete " " after "\n"
    result = result.replaceAll(RegExp(r"\n\s"), "\n");
    return result;
  }

  String formatMoney() {
    var result = this;
    result = result.replaceAllMapped(
        RegExp(r"(\d)(?=(\d{3})+(?!\d))"), (match) => "${match[1]}.");
    result += "đ";
    return result;
  }
}
