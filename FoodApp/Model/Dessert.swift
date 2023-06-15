import Foundation

struct Recipe: Codable, Identifiable {
    let id: String
    let strMeal: String
    let strMealThumb: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case strMeal
        case strMealThumb
    }
}

struct Response: Codable {
    let meals: [Recipe]
}


