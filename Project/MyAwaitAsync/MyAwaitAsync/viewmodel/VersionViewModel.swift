//
//  VersionViewModel.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import Foundation
import Combine


class VersionViewModel: NSObject {
    // @Published 어노테이션은 프로퍼티가 변경될 때 자동으로 변경됨을 호출
    @Published var response = Response<Version>()
    var cancelBag = Set<AnyCancellable>()
    
    func requestVersion() {
        let url = URL(string: "http://test.check.blossom.bumblebeecrew.com/")!
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("0.5.5", forHTTPHeaderField: "appVersion")
        
        
        /// 전달한 URLRequest (또는 URL) 에 대한 (세션 데이터) 작업을 래핑한 publisher 를 리턴
        /// `publisher` 는 작업이 완료되면 데이터를 `발행`하거나, 실패한다면 `에러`와 함께 종료된다.
        URLSession.shared.dataTaskPublisher(for: request)
        /// `.map({ $0.data })` 와 동일, keypath 문서 참고
            .map(\.data)
        /// Version 형태로 디코딩
            .decode(type: Response<Version>.self, decoder: JSONDecoder())
        /// 에러가 발생할 경우 해당 값으로 변경 (해당 처리를 하지 않을 경우 assign `호출 안됨`)
            .replaceError(with: Response(_code: Response<Version>.CodeType.failure.rawValue, message: "버전 파싱에러"))
        /// @Publised 로 선언된 프로퍼티에 저장
        /// to: 내가 할당할 프로퍼티의 `keypath`, on: `프로퍼티를 가진 객체` (현재 VersionViewModle)
            .assign(to: \.response, on: self)
        /// disposeBag 과 동일
            .store(in: &self.cancelBag)
    }
    
    /// confirm 요청
    /// - Returns: version 정보 또는 서버 메시지
    func confirmWithUrlSession(url: String?) async -> (data: Version?, msg: String?) {
        guard
            let url = url,
            let requestUrl = URL(string: url)
        else { return (nil, "url 이 누락되었습니다.") }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("ios", forHTTPHeaderField: "OsType")
        request.setValue("0.5.9", forHTTPHeaderField: "AppVersion")
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return (nil, "서버 접속 실패")
        }
        
        guard let response = try? JSONDecoder().decode(Response<Version>.self, from: data) else {
            return (nil, "JSON 파싱 에러")
        }
        
        switch response.code {
        case .success:
            return (response.result, "")
            
        default:
            return (nil, "\(response.message ?? "confirm 조회 실패")")
        }
    }
}
