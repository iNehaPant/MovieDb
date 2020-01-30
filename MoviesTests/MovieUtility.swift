//
//  MovieUtility.swift
//  MoviesTests
//
//  Created by Neha Pant on 27/01/2020.
//  Copyright © 2020 Neha Pant. All rights reserved.
//

import UIKit
@testable import Movies

class MovieUtility {
    func getMovieJSON() -> Movie? {
        guard let path = Bundle(for: type(of: self)).path(forResource: "movieData", ofType: "json") else {
                   fatalError("movieData.json not found")
               }
               do {
                   let data = try Data(contentsOf: URL(fileURLWithPath: path))
                   let comics = try JSONDecoder().decode(Movie.self, from: data)
                   return comics
                   
               } catch {
                   //handle error
                   print(error)
               }
               return nil
    }
}
