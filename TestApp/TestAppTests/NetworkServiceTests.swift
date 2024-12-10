import XCTest
@testable import TestApp

class NetworkServiceTests: XCTestCase {
    private var networkService: NetworkServiceContract!
    private let mockURLSession = URLSessionMock()

    override func setUp() {
        super.setUp()
        networkService = NetworkService(urlSession: mockURLSession)
    }

    override func tearDown() {
        networkService = nil
        super.tearDown()
    }

    func testFetchCaseStudiesForInvalidURL() {
        let invalidURL = expectation(description: "Invalid URL")
        networkService.fetchCaseStudies(urlString: "") { result in
            guard case .failure(let error) = result,
                  case .badURLRequest = error as? NetworkServiceError else {
                XCTFail("Should throw invalid url error")
                return
            }
            invalidURL.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchCaseStudiesForNoDataFailure() {
        let failure = expectation(description: "No Data")
        mockURLSession.data = nil
        networkService.fetchCaseStudies(urlString: "dummyUrlString") { result in
            guard case .failure(let error) = result,
                  case .generic = error as? NetworkServiceError else {
                XCTFail("Should throw generic error")
                return
            }
            failure.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchCaseStudiesForSuccess() {
        let success = expectation(description: "Success Data")
        mockURLSession.data = try! JSONEncoder().encode(getCaseStudies())
        networkService.fetchCaseStudies(urlString: "dummyUrlString") { result in
            guard case .success(let caseStudies) = result else {
                XCTFail("Should contain data")
                return
            }
            XCTAssertEqual(caseStudies.caseStudies?.count, 2)
            success.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchCaseStudiesForTimeoutResponseFailure() {
        let failure = expectation(description: "Timeout Response Failure")
        mockURLSession.error = NSError(domain: NSURLErrorDomain, code: URLError.timedOut.rawValue, userInfo: nil)
        networkService.fetchCaseStudies(urlString: "dummyUrlString") { result in
            guard case .failure(let error) = result else {
                XCTFail("Should throw timedOut error")
                return
            }
            XCTAssertEqual((error as NSError).code, URLError.timedOut.rawValue)
            failure.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}

private extension NetworkServiceTests {
    func getCaseStudies() -> CaseStudies {
        CaseStudies(caseStudies: [getCaseStudy(), getCaseStudyWithNilTeaser()])
    }

    func getCaseStudy() -> CaseStudy {
        CaseStudy(id: 0, teaser: "dummyTeaser", heroImage: "dummyHeroImageURL")
    }

    func getCaseStudyWithNilTeaser() -> CaseStudy {
        CaseStudy(id: 0, teaser: nil, heroImage: "dummyHeroImageURL")
    }
}
