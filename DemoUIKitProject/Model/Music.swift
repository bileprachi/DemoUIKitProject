//
//  AuthorData.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 24/02/21.
//

import Foundation

//MARK: - Root
class Root: Codable {
    let feed: Feed

    init(feed: Feed) {
        self.feed = feed
    }
}

//MARK: - Feed
class Feed: Codable {
    let title: String
    let results: [Result]
    
    init(title: String, results: [Result]) {
        self.title = title
        self.results = results
    }
}

//MARK: - Result
class Result: Codable {
    let artistName, id, releaseDate, name: String
    let copyright, artistId: String
    let artistUrl: String
    let artworkUrl100: String
    
    init(artistName: String, id: String, releaseDate: String, name: String, copyright: String, artistId: String, artistUrl: String, artworkUrl100: String) {
        self.artistName = artistName
        self.id = id
        self.releaseDate = releaseDate
        self.name = name
        self.copyright = copyright
        self.artistId = artistId
        self.artistUrl = artistUrl
        self.artworkUrl100 = artworkUrl100
    }
}
