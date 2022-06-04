//
//  URLSession+Extension.swift
//  Wildberries+Netology
//
//  Created by Николай Казанин on 04.06.2022.
//

import Foundation

extension URLSession {
    func asyncData(with request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(Data, URLResponse), Error>) in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data,
                          let response = response {
                    continuation.resume(returning: (data, response))
                } else {
                    continuation.resume(returning: (Data(), URLResponse()))
                }
            }.resume()
        }
    }
}
