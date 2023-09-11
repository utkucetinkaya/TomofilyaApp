//
//  NetworkService.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(_ router: Router, completion: @escaping (Result<T, Error>) -> Void)
}

class URLSessionNetworkService: NetworkService {

    static let shared = URLSessionNetworkService()
    private init() {}

    func request<T: Decodable>(_ router: Router, completion: @escaping (Result<T, Error>) -> Void) {

        let task = URLSession.shared.dataTask(with: router.request()) { data, response, error in

            if let error = error {
                completion(.failure(error))
                return
            }

            // Print the response status code
            if let httpResponse = response as? HTTPURLResponse {
                print("Response Status Code: \(httpResponse.statusCode)")
            }

            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))

                return
            }


            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Response data", code: 0)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch let error {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
