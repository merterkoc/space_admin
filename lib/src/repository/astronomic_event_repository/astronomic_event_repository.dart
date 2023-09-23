import 'package:dio/dio.dart';
import 'package:space_admin/core/dio/dio_client.dart';
import 'package:space_admin/core/dio/response_entity.dart';
import 'package:space_admin/src/home/pages/astronomic_event/model/astronomic_event_model.dart';

class AstronomicEventRepository {
  final dio = DioClient();

  Future<ResponseEntity<String>> addAstronomicEvent(
      AstronomicEventModel astronomicEventModel) async {
    try {
      final response = await dio.post(
        '/api/admin/event',
        astronomicEventModel.toJson(),
      );
      return ResponseEntity<String>(
        statusCode: response.statusCode ?? -1,
        message: response.statusMessage,
      );
    } on DioException catch (e) {
      return ResponseEntity<String>(
        statusCode: e.response?.statusCode ?? -1,
        message: e.toString(),
      );
    }
  }

  Future<ResponseEntity<List<AstronomicEventModel>>>
      getAstronomicEvent() async {
    try {
      final response = await dio.get(path: '/api/admin/event');
      return ResponseEntity<List<AstronomicEventModel>>(
        statusCode: response.statusCode ?? -1,
        data: response.data['data']
            .map<AstronomicEventModel>((e) => AstronomicEventModel.fromJson(e))
            .toList(),
        message: response.statusMessage,
      );
    } catch (e) {
      return ResponseEntity<List<AstronomicEventModel>>(
        statusCode: -1,
        data: [],
        message: e.toString(),
      );
    }
  }

  Future<ResponseEntity<AstronomicEventModel>> getAstronomicEventById(
      String id) async {
    try {
      final response = await dio.get(path: '/api/admin/event/$id');
      return ResponseEntity<AstronomicEventModel>(
        statusCode: response.statusCode ?? -1,
        data: AstronomicEventModel.fromJson(response.data['data']),
        message: response.statusMessage,
      );
    } catch (e) {
      return ResponseEntity<AstronomicEventModel>(
        statusCode: -1,
        message: e.toString(),
      );
    }
  }

  Future<ResponseEntity<int>> updateAstronomicEvent(
      AstronomicEventModel astronomicEventModel) async {
    try {
      final response = await dio.put(
        path: '/api/admin/event/${astronomicEventModel.id}',
        data: astronomicEventModel.toJson(),
      );
      return ResponseEntity<int>(
        statusCode: response.statusCode ?? -1,
        message: response.statusMessage,
      );
    } on DioException catch (e) {
      return ResponseEntity<int>(
        statusCode: e.response?.statusCode ?? -1,
        message: e.toString(),
      );
    }
  }
}
