import XCTest
@testable import TestApp

class CaseStudyListPresenterTests: XCTestCase {
    private var presenter: CaseStudyListPresenter!
    private let mockNetworkService = NetworkServiceMock()
    private let mockView = CaseStudyListViewMock()

    override func setUp() {
        super.setUp()
        presenter = CaseStudyListPresenter(networkService: mockNetworkService)
        presenter.view = mockView
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }

    func testGetNumberOfCaseStudiesForFailure() {
        mockNetworkService.result = .failure(NetworkServiceError.generic)
        presenter.fetchCaseStudies()
        let caseStudiesCount = presenter.getNumberOfCaseStudies()
        XCTAssertTrue(caseStudiesCount == 0)
    }

    func testGetNumberOfCaseStudiesForSuccess() {
        mockNetworkService.result = .success(getCaseStudies())
        presenter.fetchCaseStudies()
        let caseStudiesCount = presenter.getNumberOfCaseStudies()
        XCTAssertTrue(caseStudiesCount == 1)
    }

    func testGetCaseStudyForFailure() {
        mockNetworkService.result = .failure(NetworkServiceError.generic)
        presenter.fetchCaseStudies()
        XCTAssertNil(presenter.getCaseStudy(for: 0))
    }

    func testGetCaseStudyForSuccess() {
        mockNetworkService.result = .success(getCaseStudies())
        presenter.fetchCaseStudies()
        XCTAssertNotNil(presenter.getCaseStudy(for: 0))
        XCTAssertNil(presenter.getCaseStudy(for: 1))
    }

    func testDisplayErrorMessageForFailure() {
        mockNetworkService.result = .failure(NetworkServiceError.generic)
        presenter.fetchCaseStudies()
        XCTAssertTrue(mockView.shouldDisplayErrorMessage)
    }

    func testUpdateViewForSuccess() {
        mockNetworkService.result = .success(getCaseStudies())
        presenter.fetchCaseStudies()
        XCTAssertTrue(mockView.shouldUpdateViewWithCaseStudies)
    }
}

private extension CaseStudyListPresenterTests {
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
