//
//  YZArray.swift
//  YZLibraries
//
//  Created by Vipul Patel on 14/05/20.
//

import UIKit

//MARK: - Array Opetation(s)
extension Array where Element: Equatable {
    
    /// It will provide new array with Unique Elements.
    public var uniqueElements: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            if !uniqueValues.contains(item) {
                uniqueValues += [item]
            }
        }
        return uniqueValues
    }

    /// It will mutating existing array and provide unique elements wihtout generating another copy.
    public mutating func uniqueElementsInPlace() {
        var seen = [Element]()
        var index = 0
        for element in self {
            if seen.contains(element) {
                remove(at: index)
            } else {
                seen.append(element)
                index += 1
            }
        }
    }

    /// It will remove an element from existing array.
    /// - Parameter element: Equatable protocol object, which you want to remove.
    public mutating func remove(_ element: Element) {
        if let index = firstIndex(of: element) {
            remove(at: index)
        }
    }
    
    /// It will remove multiple elements from existing array.
    /// - Parameter elements: Equatable protocol objects, which you want to remove.
    public mutating func remove(_ elements: [Element]) {
        for element in elements {
            remove(element)
        }
    }
}
