//
//  Question.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/15/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation

class Question {
    
    var id:Int!
    var answerA:String!
    var answerB:String!
    var answerC:String!
    var answerD:String!
    var correctAnswer:Int!
    var milesWorth:Int!
    
    //related bonus question
    var bonusQuestion:String?
    var bonusAnswer:Bool?
    
    init(id:Int, milesWorth:Int, answerA:String, answerB:String, answerC:String, answerD:String, correctAnswer:Int){
        self.id = id
        self.milesWorth = milesWorth
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.correctAnswer = correctAnswer
    }
    
    init(id:Int, milesWorth:Int, answerA:String, answerB:String, answerC:String, answerD:String, correctAnswer:Int, bonusQuestion:String, bonusAnswer:Bool){
        self.id = id
        self.milesWorth = milesWorth
        self.answerA = answerA
        self.answerB = answerB
        self.answerC = answerC
        self.answerD = answerD
        self.correctAnswer = correctAnswer
        self.bonusQuestion = bonusQuestion
        self.bonusAnswer = bonusAnswer
    }
    
}