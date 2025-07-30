//
//  KeyChainView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 6/11/25.
//


import SwiftUI
import SoyBeanUI
import SoyBeanUtil


struct KeyChainView: View {
    struct KeyChainData: Hashable {
        var key: String
        var value: String
    }
    
    @State private var key: String = ""
    @State private var value: String = ""
    @State private var keyChainData: [KeyChainData] = []
    @State private var isDeleteMode: Bool = false
    
    var body: some View {
        VStack {
            GroupBox(label: Text("키체인")) {
                TextField(key, text: $key, prompt: Text("Key"))
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(8)
                if isDeleteMode == false {
                    TextField(value, text: $value, prompt: Text("Value"))
                        .padding(12)
                        .background(Color.white)
                        .cornerRadius(8)
                }
                Toggle("키체인 삭제", isOn: $isDeleteMode)
                if
                    (key.isEmpty == false && isDeleteMode == true) ||
                    (key.isEmpty == false && value.isEmpty == false && isDeleteMode == false)
                {
                    Spacer()
                        .frame(height: 20)
                    HStack {
                        Spacer()
                        Button(action: {
                            if isDeleteMode {
                                KeychainManager.shared.delete(forKey: key)
                            } else {
                                KeychainManager.shared.save(value, forKey: key)
                            }
                            reloadData()
                        }) {
                            Text(isDeleteMode ? "삭제" : "저장")
                        }
                        .padding(.init(horizontal: 16, vertical: 8))
                        .background(isDeleteMode ? Color.pink : Color.blue)
                        .foregroundColor(.white)
                        .clipShape(.capsule)
                    }
                }
                Button("키체인 일괄삭제") {
                    print(KeychainManager.shared.deleteAll())
                    reloadData()
                }
            }
            .animation(.default, value: isDeleteMode)
            .animation(.default, value: key)
            .animation(.default, value: value)
            
            ScrollView {
                ForEach(keyChainData, id: \.self) { data in
                    HStack {
                        Text("\(data.key)")
                        Text("\(data.value)")
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onAppear {
            reloadData()
        }
    }
    
    func reloadData() {
        keyChainData = .init()
        let dic = KeychainManager.shared.loadAll()
        dic.forEach { key, value in
            keyChainData.append(.init(key: key, value: value))
        }
    }
}

#Preview {
    KeyChainView()
}
