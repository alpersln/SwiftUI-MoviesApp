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

    var body: some View {
        NavigationView {
            List(network.results) { movie in
                NavigationLink(destination: detailView(movie: movie)) {
                    VStack {
                        if movie.backdropPath != "" {
                            WebImage(url: movie.backdropURL, options: .highPriority, context: nil)
                                .resizable()
                                .cornerRadius(10)
                        }

                        Item(description: movie.overview, name: movie.name ?? "", title: movie.title ?? "")
                    }
                }
            }
            .navigationBarTitle("Weekly Popular")
            .listStyle(PlainListStyle())
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

struct Item: View {

    var description: String
//    var vote: Double
//    var poster: String
    var name: String
    var title: String

    init(description: String, name: String, title: String) {
        self.description = description
        self.name = name
        self.title = title
    }

    var body: some View {
        VStack {
            //image
            //title text

            Text(title)
                .bold()
                .font(.system(size: 22))
            Text(name)
                .bold()
                .font(.system(size: 22))
            Text(description)
                .bold()
                .font(.system(size: 14))
                .lineLimit(2)
                .padding(.bottom,12)
                .foregroundColor(.gray)

            //vote star
            //release date
        }
    }
    
}


struct detailView: View {

    var movie: Result

    var body: some View {
        let formatted = String(format: "%.1f", movie.voteAverage)
        let SFStar = Image(systemName: "star.fill").foregroundColor(.yellow)
        ScrollView {
            VStack {
                //image
                //title text
                WebImage(url: movie.backdropURL, options: .highPriority, context: nil)
                    .resizable()
                    .cornerRadius(10)
                    .frame(height: 400)
                    .padding(.horizontal, 12)
                Text(movie.title ?? "").bold().font(.system(size: 22))
                Text(movie.name ?? "").bold().font(.system(size: 22))
                Text(movie.overview)
                    .bold()
                    .font(.system(size: 14))
                    .padding(12)
                    .foregroundColor(.black)

                HStack {

                    ForEach(0..<3){ item in
                        SFStar
                    }

                    Image(systemName: "star.lefthalf.fill").foregroundColor(.yellow)
                    Image(systemName: "star").foregroundColor(.yellow)
                    Text("(\(formatted))")
                    Spacer()
                    Text(movie.releaseDate ?? "")
                    Text(movie.firstAirDate ?? "")
                }.padding()

                //vote star
                //release date
            }
        }
    }
}
