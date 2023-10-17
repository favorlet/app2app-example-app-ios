//
//  App2AppConnectWalletRequest.swift
//  App2AppExample
//
//  Created by evahpirazzi on 2022/11/28.
//

import Foundation

public struct App2AppConnectWalletRequest: Codable {
    var action: String
    var chainId: Int
    var blockChainApp: App2AppBlockChainApp

    
    public init(
        action: String,
        chainId: Int,
        blockChainApp: App2AppBlockChainApp
    ) {
        self.action = action
        self.chainId = chainId
        self.blockChainApp = blockChainApp
    }
    
    
    public func convertParams() -> [String: Any] {
        return [
            "action": self.action,
            "chainId": self.chainId,
            "blockChainApp": self.blockChainApp.convertParams()
        ]
    }
}
