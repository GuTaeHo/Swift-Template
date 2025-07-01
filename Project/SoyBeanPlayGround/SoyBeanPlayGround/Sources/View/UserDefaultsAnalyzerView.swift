//
//  UserDefaultsAnalyzerView.swift
//  SoyBeanPlayGround
//
//  Created by 구태호 on 7/1/25.
//

import SwiftUI


struct UserDefaultsAnalyzerView: View {
    struct UserDefaultsData: Hashable {
        var key: String
        var value: String
    }
    
    @State private var key: String = ""
    @State private var value: String = ""
    @State private var userDefaultsData: [UserDefaultsData] = []
    @State private var isDeleteMode: Bool = false
    @State private var currentUserDefaultsSizeKB: Double = 0
    
    var body: some View {
        VStack {
            GroupBox(label: Text("유저디폴트")) {
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
                Toggle("값 삭제", isOn: $isDeleteMode)
                Text("현재 유저디폴트 사이즈(KB): \(currentUserDefaultsSizeKB)")
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
                                UserDefaults.standard.removeObject(forKey: key)
                            } else {
                                UserDefaults.standard.set(value, forKey: key)
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
            }
            .animation(.default, value: isDeleteMode)
            .animation(.default, value: key)
            .animation(.default, value: value)
            
            ScrollView {
                ForEach(userDefaultsData, id: \.self) { data in
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
        userDefaultsData = .init()
        let dic = UserDefaults.standard.dictionaryRepresentation()
        dic.forEach { key, value in
            userDefaultsData.append(.init(key: key, value: "\(value)"))
        }
        currentUserDefaultsSizeKB = UserDefaultsAnalyzer.analyzeUserDefaults()
    }
}

#Preview {
    UserDefaultsAnalyzerView()
}

/**
 
     // 샘플 데이터 저장
     UserDefaults.standard.set("Hello World", forKey: "greeting")
     UserDefaults.standard.set(42, forKey: "answer")
     UserDefaults.standard.set(true, forKey: "isEnabled")
     UserDefaults.standard.set(["apple", "banana", "cherry"], forKey: "fruits")
     UserDefaults.standard.set(["name": "John", "age": 30], forKey: "user")
     
     // 분석 실행
     let totalSizeMB = UserDefaultsAnalyzer.analyzeUserDefaults()
     
     print("\n=== 간단 요약 ===")
     print("UserDefaults 총 사이즈: \(String(format: "%.6f", totalSizeMB)) MB")
     
     // 특정 키 조회
     print("\n=== 특정 키 조회 ===")
     UserDefaultsAnalyzer.getValueForKey("greeting")
 */
