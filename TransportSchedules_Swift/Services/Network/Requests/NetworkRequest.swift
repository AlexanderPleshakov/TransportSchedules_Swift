import Foundation

enum HttpMethod: String {
  case get = "GET"
}

protocol NetworkRequest {
  var endpoint: String? { get }
  var httpMethod: HttpMethod { get }
  var token: String? { get }
}

extension NetworkRequest {
  var httpMethod: HttpMethod { .get }
  var token: String? { Token.token }
}

enum Token {
  static let token = "48779410-044c-4816-9677-9968d4167d86"
}
