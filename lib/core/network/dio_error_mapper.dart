import 'package:dio/dio.dart';

extension DioExceptionMapper on DioException {
  String toUserMessage() {
    final status = response?.statusCode;

    if (status == 401) return 'กรุณาเข้าสู่ระบบใหม่';
    if (status == 404) return 'ไม่พบข้อมูล';
    if (status != null && status >= 500) return 'เซิร์ฟเวอร์มีปัญหา';

    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.sendTimeout) {
      return 'เชื่อมต่อช้าเกินไป กรุณาลองใหม่';
    }

    if (type == DioExceptionType.connectionError) {
      return 'ไม่มีอินเทอร์เน็ต หรือเชื่อมต่อไม่ได้';
    }

    return 'โหลดข้อมูลไม่สำเร็จ';
  }
}
