//
//  App2AppTransaction.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 2022/12/08.
//

import Foundation

public struct App2AppTransaction: Codable {
    var from: String
    var to: String
    var value: String
    var abi: String?
    var params: String?
    var functionName: String?
    var gasLimit: String?
    
    
    public init(
        from: String,
        to: String,
        value: String,
        abi: String? = nil,
        params: String? = nil,
        functionName: String? = nil,
        gasLimit: String? = nil
    ) {
        self.from = from
        self.to = to
        self.value = value
        self.abi = abi
        self.params = params
        self.functionName = functionName
        self.gasLimit = gasLimit
    }
    
    
    public func convertParams() -> [String: Any?] {
        return [
            "from": self.from,
            "to": self.to,
            "value": self.value,
            "abi": self.abi,
            "params": self.params,
            "functionName": self.functionName,
            "gasLimit": self.gasLimit
        ]
    }
}
