//
//  Section.swift
//  testSectionHeaderDelete
//
//  Created by Howard Chang on 10/1/20.
//

import Foundation

enum SectionType: String {
    case mediumCell
}

struct Section: Hashable, Identifiable {
    let id: String
    var type: SectionType
    let title: String
    var items: [Item]
}

struct Item: Hashable, Identifiable {
    let id: String
    var name: String
}
