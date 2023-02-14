//
//  LocalLogger.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation

final class LocalLogger: LoggerProtocol {
    func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    #if DEBUG
        let output = items.map { "\($0)" }.joined(separator: separator)
        Swift.print(output, terminator: terminator)
    #endif
    }
}
