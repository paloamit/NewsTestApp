import UIKit

protocol CaseStudyListViewContract: AnyObject {
    var presenter: CaseStudyListPresenterContract? { get set }

    func displayFailureMessage()
    func updateViewWithCaseStudies()
}

final class CaseStudyListViewController: BaseViewController, CaseStudyListViewContract {
    var presenter: CaseStudyListPresenterContract?
    @IBOutlet private weak var caseStudyListTableView: UITableView!

    override static var storyboardName: String {
        "CaseStudyListView"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchCaseStudies()
        configureView()
    }

    private func configureView() {
        title = "Articles"
        caseStudyListTableView.tableFooterView = UIView()
    }

    func displayFailureMessage() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(title: "Alert", message: "Unable to fetch the data", actionTitle: "Ok")
        }
    }

    func updateViewWithCaseStudies() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.caseStudyListTableView.reloadData()
        }
    }
}

extension CaseStudyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.getNumberOfCaseStudies() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CaseStudyTableViewCell.self), for: indexPath) as? CaseStudyTableViewCell,
           let caseStudy = presenter?.getCaseStudy(for: indexPath.row) {
            cell.configure(caseStudy: caseStudy)
            return cell
        }
        return UITableViewCell()
    }
}



