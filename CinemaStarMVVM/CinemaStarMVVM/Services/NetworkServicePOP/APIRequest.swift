// APIRequest.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Клас APIRequest для типа запроса
class APIRequest<Resource: APIResourceProtocol> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

extension APIRequest: NetworkRequestProtocol {
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()

        do {
            let responce = try decoder.decode(Resource.ModelType.self, from: data)
            return responce
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func execute(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        guard let url = resource.url else { return }
        load(url, withCompletion: completion)
    }
}
