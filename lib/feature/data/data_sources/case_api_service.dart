import 'package:dio/dio.dart';

class CaseApiService {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://aounplatform.runasp.net',
      headers: {
        'accept': '*/*',
      },
    ),
  );

  Future<Response> getCases() async {
    final response = await dio.get(
      '/api/Cases',
      queryParameters: {
        'status': 'نشطة',
        'page': 1,
        'pageSize': 10,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODI3NjQ3MDgsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.LP4EgNXZK7jxXf8SfCwHC3I-7A2l2b9JUaeiRRHYJc8"

        },
      ),
    );
    return response;
  }

  Future<Response> updateCase(
      int id,
      FormData data,
      ) async {
    print(data.fields);

    return await dio.put(
      "/api/Cases/$id",
      data: data,
      options: Options(
        headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODI3NjQ3MDgsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.LP4EgNXZK7jxXf8SfCwHC3I-7A2l2b9JUaeiRRHYJc8"

          ,"accept": "*/*",

        },
      ),
    );
  }


  Future<Response> getCaseById(int id) async {
    return await dio.get(
      '/api/Cases/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODI3NjQ3MDgsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.LP4EgNXZK7jxXf8SfCwHC3I-7A2l2b9JUaeiRRHYJc8"

        },
      ),
    );
  }

  Future<Response> deleteCase(int id) async {
    const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODI3NjQ3MDgsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.LP4EgNXZK7jxXf8SfCwHC3I-7A2l2b9JUaeiRRHYJc8";
    return await dio.delete(
      '/api/Cases/$id',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "accept": "*/*",
        },
      ),
    );
  }

  Future<Response> addCase(FormData data) async {
    const String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6IkhheWFoQGdtYWlsLmNvbSIsInVpZCI6ImNjZTA0OGU5LTY2ZTAtNGRjOC05ZGYxLWUzZTUyNGU4MDhlNyIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6IkNoYXJpdHkiLCJleHAiOjE3ODI3NjQ3MDgsImlzcyI6IkFvdW5BcGkiLCJhdWQiOiJBb3VuQXBwVXNlcnMifQ.LP4EgNXZK7jxXf8SfCwHC3I-7A2l2b9JUaeiRRHYJc8";
    return await dio.post(
      '/api/Cases',
      data: data,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "accept": "*/*",
          "Content-Type": "multipart/form-data",
        },
      ),
    );
  }
}