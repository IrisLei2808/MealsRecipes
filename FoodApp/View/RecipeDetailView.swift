import SwiftUI

struct Meal: Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    let strInstructions: String
    let strIngredient1: String?
    let strIngredient2: String?
    let strMeasure1: String?
    let strMeasure2: String?
    
    var ingredients: [String] {
        var result: [String] = []
        if let ingredient1 = strIngredient1, !ingredient1.isEmpty {
            result.append(ingredient1)
        }
        if let ingredient2 = strIngredient2, !ingredient2.isEmpty {
            result.append(ingredient2)
        }
        return result
    }
    
    var measures: [String] {
        var result: [String] = []
        if let measure1 = strMeasure1, !measure1.isEmpty {
            result.append(measure1)
        }
        if let measure2 = strMeasure2, !measure2.isEmpty {
            result.append(measure2)
        }
        return result
    }
}

struct MealResponse: Codable {
    let meals: [Meal]
}

struct RecipeDetailView: View {
    let mealID: String
    
    @State private var meal: Meal?
    
    var body: some View {
        VStack {
            if let meal = meal {
                AsyncImage(urlString: meal.strMealThumb) {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                }
                Text(meal.strMeal)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                
                Text("Instructions:")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                Text(meal.strInstructions)
                    .padding(.horizontal)
                
                if !meal.ingredients.isEmpty {
                    Text("Ingredients:")
                        .font(.headline)
                        .padding(.top, 20)
                    ForEach(Array(zip(meal.ingredients, meal.measures)), id: \.0) { ingredient, measure in
                        if !ingredient.isEmpty && !measure.isEmpty {
                            Text("\(ingredient) - \(measure)")
                                .padding(.vertical, 2)
                        }
                    }
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            fetchMealDetails()
        }
    }
    
    func fetchMealDetails() {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(mealID)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(MealResponse.self, from: data) {
                    DispatchQueue.main.async {
                        self.meal = decodedResponse.meals.first
                    }
                }
            }
        }.resume()
    }
}
struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailView(mealID: "53049")
    }
}


