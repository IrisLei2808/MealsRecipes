import SwiftUI

struct RestaurantListItemView: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            AsyncImage(urlString: recipe.strMealThumb) {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.gray)
            }
            .frame(width: 80, height: 80)
            .cornerRadius(10)

            Text(recipe.strMeal)
                .font(.headline)
                .padding(.leading, 10)
        }
    }
}
