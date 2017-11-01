//
//  Singleton.swift
//  hi
//
//  Created by labuser on 10/23/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import Foundation

final class Singleton{
    
    private init() {
        
        let encodingArrayFavs:NSData = NSKeyedArchiver.archivedData(withRootObject: favoritesMovieArray) as NSData
        let encodingArrayRevs:NSData = NSKeyedArchiver.archivedData(withRootObject: reviews) as NSData

        let defaults = UserDefaults.standard
        defaults.set(encodingArrayFavs, forKey: "favorites")
        defaults.set(encodingArrayRevs, forKey: "reviews")
        defaults.synchronize()
        
        let temp1 = defaults.data(forKey: "favorites")
        favoritesMovieArray = NSKeyedUnarchiver.unarchiveObject(with: temp1!) as! [MovieData]
        
        
    }
    
    static let shared = Singleton()
    
    var favoritesMovieArray:[MovieData] = []
    var reviews:[MovieData] = []
}
