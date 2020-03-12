
import Foundation
struct  UserDetails : Codable {
	let title : String?
	let userRows : [Rows]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case userRows = "rows"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		userRows = try values.decodeIfPresent([Rows].self, forKey: .userRows)
	}

}
