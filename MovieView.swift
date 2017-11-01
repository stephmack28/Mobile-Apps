//
//  MovieView.swift
//  hi
//
//  Created by McCormack on 10/21/17.
//  Copyright © 2017 labuser. All rights reserved.
//

import Foundation
import UIKit

class MovieView: UIViewController,UITextFieldDelegate {
    
    var movieObject: MovieData!
    let sharedSingleton = Singleton.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        loadMovieView()
        //print(sharedSingleton.favoritesMovieArray.description)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let theReviewFrame = CGRect(x: self.view.frame.midX-100, y: movieObject.movieImage.size.height/8 + movieObject.movieImage.size.height/4 + 200, width: 200, height: 50)
        
        let reviewView: UITextField = UITextField(frame: theReviewFrame)
        
        reviewView.borderStyle=UITextBorderStyle.roundedRect
        reviewView.text=movieObject.myReview
        reviewView.clearsOnInsertion=true
        reviewView.returnKeyType = UIReturnKeyType.done
        //reviewView.addTarget(self, action: #selector(enterPressed), for: .editingDidEnd)
        reviewView.placeholder="Review"
        self.view.addSubview(reviewView)
        reviewView.delegate=self
        
        if movieObject.myReview == "" {
            let reviewHelpFrame = CGRect(x: 0, y: movieObject.movieImage.size.height/8 + movieObject.movieImage.size.height/4 + 250, width: self.view.frame.width, height: 30)
            let helpView = UILabel(frame: reviewHelpFrame)
            helpView.text = "Press 'Enter' to save your review!"
            helpView.textAlignment = .center
            view.addSubview(helpView)
        }else{
            let reviewLabelFrame = CGRect(x: 0, y: movieObject.movieImage.size.height/8 + movieObject.movieImage.size.height/4 + 215, width: 70, height: 30)
            let revLabelView = UILabel(frame: reviewLabelFrame)
            revLabelView.textColor=UIColor.blue
            revLabelView.text = "Review:"
            revLabelView.textAlignment = .center
            view.addSubview(revLabelView)
        }
        
        loadMovieView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        movieObject.myReview=textField.text!
        sharedSingleton.reviews.append(movieObject)
        print(textField.text!)
        return true
    }
    
    func loadMovieView(){
        
        let movieImage = movieObject.movieImage
        let movieTitle = movieObject.movieName
        let movieRating = movieObject.movieRating
        let movieDescription = movieObject.movieDesc
        let movieDate = movieObject.movieDate
        
        self.view.backgroundColor = UIColor.white
        let theImageFrame = CGRect(x: self.view.frame.midX - movieImage.size.width/8, y: 60, width: movieImage.size.width/4, height: movieImage.size.height/4)
        
        let imageView = UIImageView(frame: theImageFrame)
        
        imageView.image = movieImage
        
        view.addSubview(imageView)
        
        
        let theTitleFrame = CGRect(x: 0, y: movieImage.size.height/8 + movieImage.size.height/4, width: self.view.frame.width, height: 30)
        
        let titleView = UILabel(frame: theTitleFrame)
        titleView.text = "Movie Title: " + movieTitle
        titleView.textAlignment = .center
        
        view.addSubview(titleView)
        
        let theRatingFrame = CGRect(x: 0, y: movieImage.size.height/8 + movieImage.size.height/4 + 30, width: self.view.frame.width, height: 30)
        
        let ratingView = UILabel(frame: theRatingFrame)
        ratingView.text = "Movie Rating: " + String(movieRating)
        ratingView.textAlignment = .center
        
        view.addSubview(ratingView)
        
        let theDateFrame = CGRect(x: 0, y: movieImage.size.height/8 + movieImage.size.height/4 + 60, width: self.view.frame.width, height: 30)
        
        let dateView = UILabel(frame: theDateFrame)
        dateView.text = "Movie Release Date (YYYY-MM-DD): " + movieDate
        dateView.textAlignment = .center
        
        view.addSubview(dateView)
        
        let theDescriptionFrame = CGRect(x: 0, y: movieImage.size.height/8 + movieImage.size.height/4 + 90, width: self.view.frame.width, height: 50)
        
        let descView = UITextView(frame: theDescriptionFrame)
        descView.text = "Movie Summary: " + movieDescription
        descView.textAlignment = .center
        
        view.addSubview(descView)
        
        
        updateButtonView()
        
        
        
        
        
        
    }

    
    func updateButtonView(){
        let theFavoriteFrame = CGRect(x: self.view.frame.midX-40, y: movieObject.movieImage.size.height/8 + movieObject.movieImage.size.height/4 + 150, width: 90, height: 40)
        
        let favView :UIButton = UIButton(frame: theFavoriteFrame)
        
        if !sharedSingleton.favoritesMovieArray.contains(where: {$0.id==movieObject.id}){
            favView.backgroundColor=UIColor.yellow
            favView.setTitleColor(UIColor.black, for: .normal)
            favView.setTitle("Favorite", for: .normal)
            favView.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            favView.tag=1
        }
        else {
            favView.backgroundColor=UIColor.blue
            favView.setTitleColor(UIColor.white, for: .normal)
            favView.setTitle("Unfavorite", for: .normal)
            favView.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            favView.tag=2
        }
        
        self.view.addSubview(favView)
    }
    
    func buttonAction(sender: UIButton!){
        
        let sendTag: UIButton = sender
        if sendTag.tag == 1 { //favorite movie
            movieObject.favorite = true
            sharedSingleton.favoritesMovieArray.append(movieObject)
            updateButtonView()
        }
        if sendTag.tag == 2 { //unfavorite movie
            movieObject.favorite=false
            if let index = sharedSingleton.favoritesMovieArray.index(where: {$0.id==movieObject.id}){
                sharedSingleton.favoritesMovieArray.remove(at: index )
            }
            updateButtonView()
        }
        print(sharedSingleton.favoritesMovieArray.description)
    }
    
}
