//
//  Helpers.swift
//  MovieTicketBooking
//
//  Created by ljh on 9/2/21.
//  Copyright © 2021 JiahuaLi. All rights reserved.
//

import Foundation

func readFromJSON(_ fileName: String) -> [Movie] {
    do {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "json") else { return [] }
        let localData = NSData.init(contentsOfFile: filePath)! as Data;

        let decoder = JSONDecoder();
        let movies = try decoder.decode([Movie].self, from: localData);

        return movies;
    } catch {
        print(error.localizedDescription);
        return [];
    }
}

func saveToJSON(_ movies: [Movie], _ fileName: String) {
    do {
        guard let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("Error: No target file")
            return
        }
        let encoder = JSONEncoder();
        try encoder.encode(movies).write(to: fileURL);
    } catch {
        print(error.localizedDescription);
    }
}

func parseJsonData(data: Data) -> [Movie] {
 
    var movies: [Movie] = []
 
    do {
        let responseObj = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
 
        let rawMovies = responseObj?["results"] as! [AnyObject]
        for rawMovie in rawMovies {
            let movie = Movie(
                title: rawMovie["title"] as! String,
                date: rawMovie["release_date"] as! String,
                voteAverage: rawMovie["vote_average"] as! Double,
                overview: rawMovie["overview"] as! String,
                posterPath:  rawMovie["poster_path"] as! String
            )
            movies.append(movie)
        }
 
    } catch {
        print(error)
    }
 
    return movies
}

