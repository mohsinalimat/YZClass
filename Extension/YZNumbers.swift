//
//  YZNumbers.swift
//  YZLibraries
//
//  Created by Vipul Patel on 18/05/20.
//

import UIKit

//MARK: - Double Extension(s)
extension Double {
    
    /// It is used to convert `Double` value to `String` in K(Thousands) and M(Million) forms.
    /// - Returns: It will return `String` type value.
    public var suffixNumber: String {
        var thousandNum = self/1000
        var millionNum = self/1000000
        if self >= 1000 && self < 1000000{
            if(floor(thousandNum) == thousandNum){
                return("\(Int(thousandNum))K")
            }
            return("\(thousandNum.roundTo(1))K")
        }
        if self > 1000000{
            if(floor(millionNum) == millionNum){
                return("\(Int(thousandNum))K")
            }
            return ("\(millionNum.roundTo(1))M")
        }else{
            if(floor(self) == self){
                return ("\(Int(self))")
            }
            return ("\(self)")
        }
    }
    
    /// It is used to rounds the `Double` value to decimal places value.
    /// - Parameter places: `Int` type value to round floating point values.
    /// - Returns: It will return `Double` value.
    public mutating func roundTo(_ places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor)/divisor
    }
}
