import UIKit

final class CaseStudyTableViewCell: UITableViewCell {
    @IBOutlet private weak var caseStudyImageView: UIImageView!
    @IBOutlet private weak var caseStudyTeaserLabel: UILabel!
    @IBOutlet private weak var caseStudyContainerView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        caseStudyContainerView.createRoundedView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(caseStudy: CaseStudy) {
        caseStudyTeaserLabel.text = caseStudy.teaser
        if let heroImage = caseStudy.heroImage,
           let url = URL(string: heroImage) {
            caseStudyImageView.downLoadImage(url: url)
        }
    }
}
