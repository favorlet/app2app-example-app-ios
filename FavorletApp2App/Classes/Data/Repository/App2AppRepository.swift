//
//  App2AppRepository.swift
//  App2AppExample
//
//  Created by evahpirazzi on 2022/11/28.
//

import Foundation
 
class App2AppRepository {
    private var app2AppApi: App2AppApi = App2AppApi()
    
    
    func requestConnectWallet(
        request: App2AppConnectWalletRequest
    ) async throws -> App2AppConnectWalletResponse {
        return try await app2AppApi.requestConnectWallet(request: request)
    }
    
    
    func requestConnectWalletAndSignMessage(
        request: App2AppConnectWalletAndSignMessageRequest
    ) async throws -> App2AppConnectWalletAndSignMessageResponse {
        return try await app2AppApi.requestConnectWalletAndSignMessage(request: request)
    }
    
    
    func requestSignMessage(
        request: App2AppSignMessageRequest
    ) async throws -> App2AppSignMessageResponse {
        return try await app2AppApi.requestSignMessage(request: request)
    }
    
    
    func requestSendCoin(
        request: App2AppSendCoinRequest
    ) async throws -> App2AppSendCoinResponse {
        return try await app2AppApi.requestSendCoin(request: request)
    }
    
    
    func requestExecuteContract(
        request: App2AppExecuteContractRequest
    ) async throws -> App2AppExecuteContractResponse {
        return try await app2AppApi.requestExecuteContract(request: request)
    }
    
    
    func requestReceipt(
        requestId: String
    ) async throws -> App2AppReceiptResponse {
        return try await app2AppApi.requestReceipt(requestId: requestId)
    }
    
    
    
}
