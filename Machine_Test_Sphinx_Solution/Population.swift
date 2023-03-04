//
//  Population.swift
//  Machine_Test_Sphinx_Solution
//
//  Created by Mac on 04/03/23.
//

import Foundation
struct Population : Decodable{
    let population : [Population]
    enum Codinkeys : CodingKey{
        case population
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codinkeys.self)
        self.population
    }
}
