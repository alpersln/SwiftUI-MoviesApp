//
//  ContentView.swift
//  Movies
//
//  Created by calatinalper on 4.09.2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
        
    @ObservedObject var network = MovieViewModel()
   // let movies: [Result]
    

    
    var body: some View {
        NavigationView{
           
               // Text(viewModel.description).font(.system(size: 14))
            List(network.results){movies in
                NavigationLink(destination: detailView(maurl:movies.backdropURL,description: movies.overview, name: movies.name ?? "", title: movies.title ?? "", votes: movies.voteAverage, date: movies.releaseDate ?? "", date2: movies.firstAirDate ?? "")) {
                VStack{
                    
                if movies.backdropPath != "" {
                    WebImage(url: movies.backdropURL,
                             options: .highPriority,
                             context: nil).resizable().cornerRadius(10)
                }
                    
                    Item(description: movies.overview, name: movies.name ?? "", title: movies.title ?? "")
              //  Item(description: movies.description)
                }
                }
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
            
            
            Text(title).bold().font(.system(size: 22))
            Text(name).bold().font(.system(size: 22))
            Text(description).bold().font(.system(size: 14)).lineLimit(2).padding(.bottom,12).foregroundColor(.gray)
   //         Text(String(vote))

            //vote star
            //release date
        }
    }
    
}


struct detailView: View {

    

  //  let make : MovieViewModel
    var maurl: URL
    var description: String
 //   var vote: Double
//    var poster: String
    var name: String
    var title: String
    var votes: Double
    var date: String
    var date2: String
    
    init(maurl:URL,description: String, name: String, title: String, votes: Double, date: String, date2: String){
        self.maurl = maurl
        self.description = description
        self.name = name
        self.title = title
        self.votes = votes
        self.date = date
        self.date2 = date2
    }
    var body: some View {
        let formatted = String(format: "%.1f", votes)
        let SFStar = Image(systemName: "star.fill").foregroundColor(.yellow)
        VStack{
            //image
            //title text
            WebImage(url: maurl,
                     options: .highPriority,
                     context: nil).resizable().cornerRadius(10).frame(width: 400, height: 400)
            Text(title).bold().font(.system(size: 22))
            Text(name).bold().font(.system(size: 22))
            Text(description).bold().font(.system(size: 14)).padding(12).foregroundColor(.black)
            HStack{
                
                ForEach(0..<3){ item in
                    SFStar
                }
                Image(systemName: "star.lefthalf.fill").foregroundColor(.yellow)
                Image(systemName: "star").foregroundColor(.yellow)
                Text("(\(formatted))")
                Spacer()
                Text(date)
                Text(date2)
            }.padding()
            
   //         Text(String(vote))

            //vote star
            //release date
        }
    }
}
