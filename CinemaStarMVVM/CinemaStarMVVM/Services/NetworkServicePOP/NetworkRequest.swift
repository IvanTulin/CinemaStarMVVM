// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

protocol NetworkRequestProtocol: AnyObject {
    associatedtype ModelType
    func decode(_ data: Data) -> ModelType?
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequestProtocol {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("HN22RMS-ZDXMNWJ-H7FY4Y5-W90A18G", forHTTPHeaderField: "X-API-KEY")

        let task = URLSession.shared.dataTask(with: request) { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let data = data, let value = self.decode(data) else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            DispatchQueue.main.async {
                completion(value)
            }
        }
        task.resume()
    }
}
