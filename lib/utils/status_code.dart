
class StatusCode {
  static withdrawStatus(String code) {
    switch (code) {
      case '0':
        return 'Pending';
      case '1':
        return 'Completed';
      default:
        return '';
    }
  }

  static String getStatusCode(String code) {
    switch (code) {
      case '0':
        return 'Inactive';
      case '1':
        return 'Active';
      default:
        return '';
    }
  }
}
