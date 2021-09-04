//
//  ContentView.swift
//  Movies
//
//  Created by calatinalper on 4.09.2021.
//

import SwiftUI

struct ContentView: View {
        
    @ObservedObject var network = MovieViewModel()
   // let movies: [Result]
    

    
    var body: some View {
        NavigationView{
           
               // Text(viewModel.description).font(.system(size: 14))
            List(network.results){movies in
                Item(description: movies.overview, name: movies.name ?? "", title: movies.title ?? "")
              //  Item(description: movies.description)
               
            }
            .navigationBarTitle("Weekly Popular")
        } .onAppear {
            self.network.fetchMovies()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//https://api.themoviedb.org/3/trending/all/week?api_key=15c159bf5e0db119c2aea4ad8b832788

struct Item: View {
    
    var description: String
 //   var vote: Double
//    var poster: String
    var name: String
    var title: String
    
    init(description: String, name: String, title: String){
        self.description = description

        self.name = name
        self.title = title
    }
    
    var body: some View {
        VStack{
            //image
            //title text
            
            Text(description).bold().font(.system(size: 14))
   //         Text(String(vote))
            Text(title)
            Text(name)
            //vote star
            //release date
        }
    }
    
}
