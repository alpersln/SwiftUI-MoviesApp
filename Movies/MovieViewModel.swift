//
//  MovieViewModel.swift
//  Movies
//
//  Created by calatinalper on 4.09.2021.
//

import Foundation

struct MovieModel: Codable {
//   let page: Int
    let results: [Result]
//    let totalPages, totalResults: Int
}

// MARK: - Result
struct Result: Codable,Identifiable {
    
    let id: Double
    let overview: String
//    let vote_average: Int?
//    let firstAirDate, originalName: String?
//    let originCountry: [String]?
//    let genreIDS: [Int]
//    let voteCount: Int
//    let originalLanguage: OriginalLanguage
//    let id: Int
//    let poster_path: String
    let name: String?
//    let backdropPath: String
//    let popularity: Double
//    let mediaType: MediaType
//    let adult: Bool?
//    let originalTitle: String?
//    let video: Bool?
    let title: String?
    let releaseDate: String?
}



class MovieViewModel: ObservableObject {
    
    @Published var results = [Result]()
    
 //   @Published var description: String = ""
    
//
//
//    init() {
//        fetchMovies()
//    }
    
    func fetchMovies(){
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/all/week?api_key=15c159bf5e0db119c2aea4ad8b832788") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data , error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let result = try decoder.decode(MovieModel.self, from: data)
                
                DispatchQueue.main.async {
                    self.results = result.results
                }
            }
            catch {
                print("failed")
            }
        }
        task.resume()
    }
}
