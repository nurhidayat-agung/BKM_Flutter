import 'package:newbkmmobile/repositories/session_manager_repository.dart';
import 'package:newbkmmobile/services/http_communicator.dart';

/// Repository
class LeaveRepository {

  Future<(int, dynamic)> submitLeave(int leaveType, String start, String end, String reason) async {
    final driver = await SessionManager.getUserSession();

    final endpoint = 'leaves';
    final headers = {
      'X-Site-ID': driver?.siteId ?? "",
      'Authorization': 'Bearer ${driver?.token ?? ""}',
      'X-Client-Type': 'mobile'
    };

    final response = await HttpCommunicator()
        .postJson(endpoint,
        body: {
          "user_id": driver?.userId ?? "",
          "leave_type_id": leaveType.toString(),
          "start_date": start,
          "end_date": end,
          "reason": reason,
        },
        headers: headers
    );

    return (response.status, response.result);
  }

  /// 🔥 Method baru: GET list cuti berdasarkan userId
  Future<(int, dynamic)> getLeavesByUser() async {
    final driver = await SessionManager.getUserSession();

    final endpoint = 'leaves/user/${driver?.userId ?? ""}';

    final headers = {
      'Accept': 'application/json',
      'X-Site-ID': driver?.siteId ?? "",
      'Authorization': 'Bearer ${driver?.token ?? ""}',
      'X-Client-Type': 'mobile',
    };

    final response = await HttpCommunicator().get(
      endpoint,
      headers: headers,
    );

    return (response.status, response.result);
  }

}