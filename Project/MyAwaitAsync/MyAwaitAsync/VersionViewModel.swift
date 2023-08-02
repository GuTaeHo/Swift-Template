//
//  VersionViewModel.swift
//  MyAwaitAsync
//
//  Created by 구태호 on 2023/07/30.
//

import Foundation


class VersionViewModel: NSObject {
    
    func confirmWithUrlSession(url: String?) async throws -> Response<Version>? {
        guard
            let url = url,
            let requestUrl = URL(string: url)
        else { return nil }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        request.setValue("ios", forHTTPHeaderField: "OsType")
        request.setValue("0.5.9", forHTTPHeaderField: "AppVersion")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        return try JSONDecoder().decode(Response<Version>.self, from: data)
    }
}
