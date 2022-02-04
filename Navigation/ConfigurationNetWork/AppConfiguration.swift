//
//  AppConfiguration.swift
//  Navigation
//
//  Created by TIS Developer on 04.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

enum AppConfiguration {
    
    case peopleURL(String)
    case starshipsURL(String)
    case planetsURL(String)

    static func getArrayURL() -> [AppConfiguration] {
        return [AppConfiguration.peopleURL("https://swapi.dev/api/people/8"),
                AppConfiguration.starshipsURL("https://swapi.dev/api/starships/3"),
                AppConfiguration.planetsURL("https://swapi.dev/api/planets/5")]
    }
}
