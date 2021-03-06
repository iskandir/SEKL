//
//  RecipesView.swift
//  SEKL
//
//  Created by Dennis Hasselbusch on 20.03.20.
//  Copyright © 2020 Dennis Hasselbusch. All rights reserved.
//

import SwiftUI
/*
    Rezept Bibliothek 
 **/
struct RecipesView: View {
    @State private var showingAddRecipe = false
    @ObservedObject var expenses = Expense()
    @EnvironmentObject var recipe : Recipe
    
    var body: some View {
        NavigationView {
            List {
                ForEach(recipe.items){ item in
                    HStack{
                        VStack(alignment: .leading){
                            Text(item.beschreibung)
                                .font(.headline)
                        }
                    }
                }.onDelete(perform: removeRecipes)
            }.onAppear(perform: {UITableView.appearance().separatorStyle = .none})
            .opacity(0.7)
            .background(Image("Background")
            .resizable()
            .edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Rezepte")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddRecipe = true
                                    }){
                                        Image(systemName: "book.fill")
                                    })
                                    .sheet(isPresented: $showingAddRecipe){
                                        AddRecipeToRecipeBook(recipe: self.recipe)
                                    }
        }
    }
    
    func removeRecipes(at offsets: IndexSet){
        recipe.items.remove(atOffsets: offsets)
    }
    
}
struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
