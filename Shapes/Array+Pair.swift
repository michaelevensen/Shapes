//
//  Array+Pair.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 7/14/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//
import Foundation

extension Array {
    
    /**
        Returns a multi-array with pairable values defined by count
        - Pairing defaults to 2
    */
    func pair(count: Int? = 2) -> Array<Array<T>> {
        
        var pa: Array<Array<T>> = []
        var temp: Array<T> = []
        
        for value in self {
            temp += value
            
            if temp.count % count! == 0 {
                pa += temp
                temp = []
            }
        }
        
        return pa
    }
    
    /**
        Returns a tuple with pairable values defined by count
        - Pairing defaults to 2
    */
    func pairWithTuples(count: Int? = 2) -> Array<(A: T, B: T)> {
        
        var pa: Array<(A: T, B: T)> = []
        var temp: Array<T> = []
        
        for value in self {
            temp += value
            
            if temp.count % count! == 0 {
                pa += (temp[0], temp[1])
                temp = []
            }
        }
        
        return pa
    }
}
