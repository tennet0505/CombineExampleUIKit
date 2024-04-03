//
//  Observable.swift
//  CombineExampleUIKit
//
//  Created by Oleg Ten on 07/07/2022.
//

import Foundation

class Obser<T> {
    
    var value: T? {
        didSet {
            listener?(value)
        }
    }
    init(_ value: T?) {
        self.value = value
    }
    
    var listener: ((T?) -> Void)?
    
    func bind(listener: @escaping (T?) -> Void) {
        listener(value)
        self.listener = listener
    }
}
