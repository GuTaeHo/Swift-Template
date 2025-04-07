//
//  GIFImageTestView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 4/3/25.
//

import SwiftUI


struct GIFImageTestView: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = width * 2 / 5
            GIFSDWebImageView(imageURL: "https://ad-file.isdata.kr:31000/imageFile?filename=뷰티엑스포 배너 _대구로 - 박세영.gif")
                .aspectRatio(5 / 2,
                             contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
        }
    }
}

#Preview {
    GIFKingfisherView(imageURL: "https://ad-file.isdata.kr:31000/imageFile?filename=뷰티엑스포 배너 _대구로 - 박세영.gif")
}
