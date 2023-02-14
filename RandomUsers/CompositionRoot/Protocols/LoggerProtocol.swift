//
//  LoggerProtocol.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation

protocol LoggerProtocol {
    func log(_ items: Any..., separator: String, terminator: String)
}

extension LoggerProtocol {
    func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        log(items, separator: separator, terminator: terminator)
    }
}
