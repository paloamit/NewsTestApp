import Foundation
@testable import KinCartaTestApp

class URLSessionDataTaskMock: URLSessionDataTaskProtocol {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }

    func resume() {
        closure()
    }
}
