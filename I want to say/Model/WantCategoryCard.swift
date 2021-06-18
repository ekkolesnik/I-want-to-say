//
//  WantCategoryCard.swift
//  I want to say
//
//  Created by Evgeny Kolesnik on 14.06.2021.
//

import Foundation

struct WantCategoryCard: Hashable, Identifiable {
    var id = UUID()
    let title: String
    let image: String
}
