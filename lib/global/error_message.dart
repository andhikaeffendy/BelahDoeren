class ErrorMessage {
  static final String error_500 = "Server error";
  static final String error_504 = "Server timeout";
  static final String error_404 = "Server tidak ditemukan";
  static final String error_403 = "URL tidak diperbolehkan";
  static final String error_401 = "Tidak memiliki akses";
  static final String error_400 = "Reques tidak sesuai";
  static final String error_0 = "Tidak ada koneksi internet";

  static String getMessage(int errorCode){
    switch (errorCode) {
      case 504: return error_500;
      case 404: return error_404;
      case 403: return error_403;
      case 401: return error_401;
      case 400: return error_400;
      case 0: return error_0;
      default: return error_500;
    }
  }
}