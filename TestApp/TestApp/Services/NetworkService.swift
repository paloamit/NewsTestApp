import Foundation

typealias FetchCaseStudiesCompletion = (_ result: Result<CaseStudies, Error>) -> Void

protocol NetworkServiceContract {
    func fetchCaseStudies(urlString: String, completion: @escaping FetchCaseStudiesCompletion)
}

final class NetworkService: NetworkServiceContract {
    
    private let urlSession: URLSession?

    init(urlSession: URLSession?) {
        self.urlSession = urlSession
    }

    func fetchCaseStudies(urlString: String, completion: @escaping FetchCaseStudiesCompletion) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkServiceError.badURLRequest))
            return
        }

        urlSession?.dataTask(with: url, completionHandler: { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let caseStudies = try JSONDecoder().decode(CaseStudies.self, from: data)
                    completion(.success(caseStudies))
                } catch {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NetworkServiceError.generic))
            }
        }).resume()
    }
}

enum NetworkServiceError: Error {
    case badURLRequest
    case generic
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
}
