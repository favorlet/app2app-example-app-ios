//
//  App2AppConnectWalletAndSignMessageRequest.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 10/17/23.
//

import Foundation

public struct App2AppConnectWalletAndSignMessageRequest: Codable {
    var action: String
    var chainId: Int
    var blockChainApp: App2AppBlockChainApp
    var connectWalletAndSignMessage: App2AppConnectWalletAndSignMessage

    
    public init(
        action: String,
        chainId: Int,
        blockChainApp: App2AppBlockChainApp,
        connectWalletAndSignMessage: App2AppConnectWalletAndSignMessage
    ) {
        self.action = action
        self.chainId = chainId
        self.blockChainApp = blockChainApp
        self.connectWalletAndSignMessage = connectWalletAndSignMessage
    }
    
    public func convertParams() -> [String: Any] {
        return [
            "action": self.action,
            "chainId": self.chainId,
            "blockChainApp": self.blockChainApp.convertParams(),
            "connectWalletAndSignMessage": self.connectWalletAndSignMessage.convertParams()
        ]
    }
}
