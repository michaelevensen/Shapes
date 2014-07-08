//
//  Float+Conversion.swift
//  Shapes
//
//  Created by Michael Nino Evensen on 7/3/14.
//  Copyright (c) 2014 Michael Nino Evensen. All rights reserved.
//
import UIKit

extension CGFloat {
    
    func toRadians() -> CGFloat {
        
        return self * CGFloat(M_PI) / 180
    }
}