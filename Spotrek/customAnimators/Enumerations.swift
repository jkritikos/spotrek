//
//  SPEnumerations.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

//All supported custom transitions

import Foundation

import Foundation
import UIKit

enum TransitionType {

    case RightToLeft,
         LeftToRight,
         CrossDisolve,
         UpToBottom,
         BottomToUp
}

enum Direction {
    
    case Horizontal,
         Vertical
}

enum QuestionNumber: Int {
    
    case A = 1, B, C, D
}

//Http Related
enum CommandUrlKey:String {
    
    case kGetAvailableQuestionsForTrek = "http://spotrek.boomar.gr/api/getAvailableQuestions" ,
         kGetBlaBlaBla = "http://Bla.Bla.com"
    
}

