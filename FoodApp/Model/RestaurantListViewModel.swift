import Foundation

class RestaurantListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    func fetchRecipes() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = response.meals
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Error fetching data: \(error)")
            }
        }.resume()
    }
    
    
    
}

