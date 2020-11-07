//
//  GlobalExtension.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 07.11.2020.
//

import Foundation

public func ensureMainThread(execute work: @escaping @convention(block) () -> Void) {
    if Thread.isMainThread {
        work()
    } else {
        DispatchQueue.main.async {
            work()
        }
    }
}

public func isExistValue<T>(_ input: T?) -> Bool {
    return input != nil
}

public func isNotExistValue<T>(_ input: T?) -> Bool {
    return input == nil
}
