import Foundation
@testable import KinCartaTestApp

final class CaseStudyListViewMock: CaseStudyListViewContract {
    var presenter: CaseStudyListPresenterContract?
    var shouldDisplayErrorMessage = false
    var shouldUpdateViewWithCaseStudies = false

    func displayFailureMessage() {
        shouldDisplayErrorMessage = true
    }

    func updateViewWithCaseStudies() {
        shouldUpdateViewWithCaseStudies = true
    }
}
