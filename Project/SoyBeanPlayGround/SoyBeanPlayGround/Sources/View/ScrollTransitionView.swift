//
//  ScrollTransitionView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 8/8/25.
//

import SwiftUI


@available(iOS 17.0, *)
struct ScrollTransitionView: View {
    var body: some View {
        ScrollView {
            ForEach(ScrollTransitionListItem.previewItems) { item in
                item.color
                    .frame(height: 300)
                    .overlay {
                        Text(item.title)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .scrollTransition { effect, phase in
                        switch phase {
                        case .topLeading:
                            effect
                                .opacity(0) // 보이기 직전 완전 투명
                                .offset(x: -200)
                        case .identity:
                            effect
                                .opacity(1) // 완전 보임
                                .offset(x: 0)
                        case .bottomTrailing:
                            effect
                                .opacity(0) // 사라지기 직전 투명
                                .offset(x: 200)
                        }
                    }
            }
        }
    }
}
