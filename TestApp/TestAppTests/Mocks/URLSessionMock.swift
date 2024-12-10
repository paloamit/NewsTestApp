import Foundation
@testable import KinCartaTestApp

class URLSessionMock: URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var response: URLResponse?
    var error: Error?

    func dataTask(with url: URL, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskMock {
        return URLSessionDataTaskMock{ [weak self] in
            guard let self = self else { return }
            completionHandler(self.data, self.response, self.error)
        }
    }
}
