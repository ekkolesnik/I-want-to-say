//
//  WantCategoryCard.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import Foundation

struct WantCategoryCard: Hashable, Identifiable, Codable {
    var id = UUID()
    let title: String
    let image: String
}

struct FoodCategoryCard: Hashable, Identifiable, Codable {
    var id = UUID()
    let title: String
    let image: String
}

struct HoodCategoryCard: Hashable, Identifiable, Codable {
    var id = UUID()
    let title: String
    let image: String
}

struct GeneralCategoryCard: Hashable, Identifiable, Codable {
    var id = UUID()
    let title: String
    let image: String
}
