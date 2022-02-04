//
//  NetworkService.swift
//  Navigation
//
//  Created by TIS Developer on 04.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation


struct NetworkService {
    static func fetchData(with configuration: AppConfiguration) {
        guard let url = getURL(from: configuration) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Произошла ошибка при выполнении запроса \(error)")
                print("Произошла ошибка при выполнении запроса \(error.localizedDescription)") //The Internet connection appears to be offline.  Code=-1009
                return
            }


            guard let httpResponse = response as? HTTPURLResponse else { return }
            print("----------------------  http response ")
            print(httpResponse.statusCode)
            print(httpResponse.allHeaderFields)
            
            guard let data = data else { return }

            print("----------------------  data ")
            print(data)
        }.resume()
    }

    static func getURL(from configuration: AppConfiguration) -> URL? {
        switch configuration {
        case .peopleURL(let urlString):
            return URL(string: urlString)
        case .planetsURL(let urlString):
            return URL(string: urlString)
        case .starshipsURL(let urlString):
            return URL(string: urlString)
        }
    }
}
