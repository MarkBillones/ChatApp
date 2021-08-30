//
//  Protocol.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/21/21.
//

import Foundation

protocol mapDataVCDelegate {
    func sendValue(countryText: String, zipCodeText: String, cityText: String, provinceText: String)
}

protocol mealsDataDelegate {
    func sendValue(selectedCategory: String)
}

