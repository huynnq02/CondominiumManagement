import 'package:dio/dio.dart';
import 'package:untitled/repository/base/base_repository.dart';
import 'package:untitled/src/models/bill.dart';

class BillAPIRepository extends BaseRepository {
  Future<Response> getBill() async {
    try {
      var client = init();

      final apartmentsResponse =
          await client.get('/api/services/app/Bill/CreateServiceBill');

      return apartmentsResponse;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getAllAparmentBilllAPIRepository() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetCurrentUserApartmentBill',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getAllServiceBillAPIRepository() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetCurrentUserServiceBill',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> editApartmentBillAPIRepository(
      ApartmentBill aparmentBill) async {
    try {
      var client = init();
      print("id ne:");
      print(aparmentBill.id);
      final authRespone =
          await client.post('/api/services/app/Bill/EditApartmentBill', data: {
        "id": aparmentBill.id,
        "dataPayment": DateTime.now().toIso8601String(),
        "state": "Chờ tiếp nhận",
        "billName": aparmentBill.billName,
      });
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> editServiceBillAPIRepository(ServiceBill serviceBill) async {
    try {
      var client = init();
      print("id ne:");
      print(serviceBill.id);
      final authRespone =
          await client.post('/api/services/app/Bill/EditServiceBill', data: {
        "id": serviceBill.id,
        "billID": serviceBill.billID,
        "serviceID": serviceBill.serviceId,
        "billName": serviceBill.billName,
        "emailAddress": serviceBill.emailAddress,
        "ownerName": serviceBill.ownerName,
        "createDay": serviceBill.createDay,
        "createName": serviceBill.createName,
        "serviceName": serviceBill.serviceName,
        "cycle": serviceBill.cycle,
        "startDay": serviceBill.startDay,
        "endDay": serviceBill.endDay,
        "paymentTerm": serviceBill.paymentTerm,
        "note": serviceBill.note,
        "state": "Chờ tiếp nhận",
        "picture": "",
        "price": serviceBill.price,
        "datePayment": DateTime.now().toIso8601String(),
      });
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }

  Future<Response> getTotalUnpaid() async {
    try {
      var client = init();

      final authRespone = await client.get(
        '/api/services/app/Bill/GetTotalUnpaid',
      );
      return authRespone;
    } on DioError catch (error) {
      return error.response as Response;
    }
  }
}
