// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import KeychainSwift

/// Протокол NetworkRequestProtocol
protocol NetworkRequestProtocol: AnyObject {
    /// ассоциативный тип
    associatedtype ModelType
    /// декодируем данные
    /// - Parameters:
    /// data: данные полученные из сервера
    func decode(_ data: Data) -> ModelType?

    /// декодируем данные
    /// - Parameters:
    /// completion: клоужер для обработки результатов
    func execute(withCompletion completion: @escaping (ModelType?) -> Void)
}

extension NetworkRequestProtocol {
    func load(_ url: URL, withCompletion completion: @escaping (ModelType?) -> Void) {
        let keychain = KeychainSwift()
        keychain.set("HN22RMS-ZDXMNWJ-H7FY4Y5-W90A18G", forKey: "keychainToken")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(keychain.get("keychainToken"), forHTTPHeaderField: "X-API-KEY")

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
