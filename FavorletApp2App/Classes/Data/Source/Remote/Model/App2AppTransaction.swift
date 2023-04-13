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
    var abi: String? = nil
    var params: String? = nil
    var functionName: String? = nil
    var data: String? = nil
    var gasLimit: String? = nil
    
    // SendCoin
    public init(
        from: String,
        to: String,
        value: String
    ) {
        self.from = from
        self.to = to
        self.value = value
    }
    
    // ExecuteContract
    public init(
        from: String,
        contract: String,
        value: String,
        abi: String,
        params: String,
        functionName: String,
        gasLimit: String? = nil
    ) {
        self.from = from
        self.to = contract
        self.value = value
        self.abi = abi
        self.params = params
        self.functionName = functionName
        self.gasLimit = gasLimit
    }
    
    // ExecuteContractWithEncoded
    public init(
        from: String,
        contract: String,
        value: String,
        data: String,
        gasLimit: String? = nil
    ) {
        self.from = from
        self.to = contract
        self.value = value
        self.data = data
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
            "data": self.data,
            "gasLimit": self.gasLimit
        ]
    }
}
