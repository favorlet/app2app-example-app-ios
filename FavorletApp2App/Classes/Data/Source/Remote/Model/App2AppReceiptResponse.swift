//
//  App2AppReceiptResponse.swift
//  App2AppExample
//
//  Created by evahpirazzi on 2022/11/28.
//

import Foundation

public struct App2AppReceiptResponse: Decodable {
    public var requestId: String?
    public var expiredAt: Int?
    public var action: String?
    public var chainId: Int?
    public var connectWallet: App2AppReceiptResponse.ConnectWallet?
    public var signMessage: App2AppReceiptResponse.SignMessage?
    public var transactions: [App2AppReceiptResponse.Transaction]?
    public var error: App2AppError?
    
    
    public struct ConnectWallet: Decodable {
        public var status: String?
        public var address: String?
        public var errorMessage: String?
    }
    
    
    public struct SignMessage: Decodable {
        public var status: String?
        public var signature: String?
        public var errorMessage: String?
    }
    
    
    public struct Transaction: Decodable {
        public var status: String?
        public var txHash: String?
        public var errorMessage: String?
    }
}
