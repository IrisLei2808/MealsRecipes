import SwiftUI

struct RestaurantListView: View {
    @ObservedObject private var viewModel = RestaurantListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.recipes) { meal in
                NavigationLink(destination: RecipeDetailView(mealID: meal.id)) {
                    RestaurantListItemView(recipe: meal)
                }
            }
            .navigationTitle("Dessert Recipes")
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}

