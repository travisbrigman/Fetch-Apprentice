//
//  Provider.swift
//  Fetch-Apprentice
//
//  Created by Travis Brigman on 8/13/21.
//

import Foundation

class Provider {
    
    func getResults(query: String, completed: @escaping (Result<Categories, ErrorMessage>) -> Void) {
        
        guard let url = URL(string: query) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(Categories.self, from: data)
                completed(.success(results))
                
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
        
    }
}

