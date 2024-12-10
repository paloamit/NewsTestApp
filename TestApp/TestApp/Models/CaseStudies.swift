import Foundation

struct CaseStudies: Codable {
    let caseStudies: [CaseStudy]?
    
    private enum CodingKeys : String, CodingKey {
        case caseStudies = "case_studies"
    }
}

struct CaseStudy: Codable {
    let id: Int?
    let teaser: String?
    let heroImage: String?
    
    private enum CodingKeys : String, CodingKey {
        case id
        case teaser
        case heroImage = "hero_image"
    }
}
