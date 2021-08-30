//
//  APIModels.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/24/21.
//

import Foundation

struct MealsAPIResponse: Codable {
    let meals: [ByCategory]
}

struct ByCategory: Codable {
    let idMeal: String
    let strMeal: String?
    let strMealThumb: String
}

struct CategoriesAPIResponse: Codable {
    let categories: [CategoryList]
}

struct CategoryList: Codable {
    let idCategory: String
    let strCategory: String?
    let strCategoryThumb: String
    let strCategoryDescription: String
}

struct lookupAPIResponce: Codable {
    let meals: [lookupID]
}

struct lookupID: Codable {
    let strMealThumb: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strInstructions: String
    
}
