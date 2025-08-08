//
//  ScrollTransitionListItem.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 8/8/25.
//

import SwiftUI


struct ScrollTransitionListItem: Identifiable {
    let id = UUID()
    let title: String
    let color: Color
    
    static let previewItems: [Self] = [
        ScrollTransitionListItem(title: "Row 1", color: .red),
        ScrollTransitionListItem(title: "Row 2", color: .blue),
        ScrollTransitionListItem(title: "Row 3", color: .green),
        ScrollTransitionListItem(title: "Row 4", color: .orange),
        ScrollTransitionListItem(title: "Row 5", color: .pink),
    ]
}
