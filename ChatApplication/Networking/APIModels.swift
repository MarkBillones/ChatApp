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
}
