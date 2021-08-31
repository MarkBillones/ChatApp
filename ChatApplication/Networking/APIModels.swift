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
    let strInstructions: String
    let strIngredient1: String
    let strIngredient2: String
    let strIngredient3: String
    let strIngredient4: String
    let strIngredient5: String
    let strIngredient6: String
    let strMeasure1: String
    let strMeasure2: String
    let strMeasure3: String
    let strMeasure4: String
    let strMeasure5: String
    let strMeasure6: String
}
