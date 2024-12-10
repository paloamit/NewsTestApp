import Foundation

protocol CaseStudyListPresenterContract {
    var view: CaseStudyListViewContract? { get set }

    func fetchCaseStudies()
    func getNumberOfCaseStudies() -> Int
    func getCaseStudy(for index: Int) -> CaseStudy?
}

final class CaseStudyListPresenter: CaseStudyListPresenterContract {
    weak var view: CaseStudyListViewContract?
    private let networkService: NetworkServiceContract?
    private var caseStudies: [CaseStudy]?
    
    init(networkService: NetworkServiceContract?) {
        self.networkService = networkService
    }

    func fetchCaseStudies() {
        let urlString = "https://raw.githubusercontent.com/theappbusiness/engineering-challenge/main/endpoints/v1/caseStudies.json"
        networkService?.fetchCaseStudies(urlString: urlString, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let caseStudies):
                self.caseStudies = caseStudies.caseStudies?.filter { $0.teaser != nil }
                self.view?.updateViewWithCaseStudies()
            case .failure:
                self.view?.displayFailureMessage()
            }
        })
    }

    func getNumberOfCaseStudies() -> Int {
        caseStudies?.count ?? 0
    }

    func getCaseStudy(for index: Int) -> CaseStudy? {
        if let count = caseStudies?.count,
           index < count,
           let caseStudy = caseStudies?[index] {
            return caseStudy
        }
        return nil
    }
}
