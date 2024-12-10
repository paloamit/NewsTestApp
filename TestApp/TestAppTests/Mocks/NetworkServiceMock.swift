import Foundation
@testable import KinCartaTestApp

final class NetworkServiceMock: NetworkServiceContract {
    var result: Result<CaseStudies, Error>?

    func fetchCaseStudies(urlString: String, completion: @escaping FetchCaseStudiesCompletion) {
        guard let result = result else {
            return
        }
        completion(result)
    }
}
