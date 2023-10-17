//
//  App2AppConnectWalletAndSignMessage.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 10/17/23.
//

import Foundation

public struct App2AppConnectWalletAndSignMessage: Codable {
    
    var value: String
    
    
    public init(
        value: String
    ) {
        self.value = value
    }
    
    
    public func convertParams() -> [String: Any] {
        return [
            "value": self.value
        ]
    }
}
