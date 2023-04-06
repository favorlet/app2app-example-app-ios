//
//  App2AppComponent.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 2022/12/07.
//

import Foundation

public class App2AppComponent: App2AppProtocol {
    
    private let requestConnectWalletUseCase: RequestConnectWalletUseCase
    private let requestSignMessageUseCase: RequestSignMessageUseCase
    private let requestSendCoinUseCase: RequestSendCoinUseCase
    private let requestExecuteContractUseCase: RequestExecuteContractUseCase
    private let executeUseCase: ExecuteUseCase
    private let receiptUseCase: ReceiptUseCase
    
    public init() {
        self.requestConnectWalletUseCase = RequestConnectWalletUseCase()
        self.requestSignMessageUseCase = RequestSignMessageUseCase()
        self.requestSendCoinUseCase = RequestSendCoinUseCase()
        self.requestExecuteContractUseCase = RequestExecuteContractUseCase()
        self.executeUseCase = ExecuteUseCase()
        self.receiptUseCase = ReceiptUseCase()
    }
    
    public func requestConnectWallet(
        request: App2AppConnectWalletRequest
    ) async throws -> App2AppConnectWalletResponse {
        return try await requestConnectWalletUseCase.execute(request: request)
    }
    
    public func requestSignMessage(
        request: App2AppSignMessageRequest
    ) async throws -> App2AppSignMessageResponse {
        return try await requestSignMessageUseCase.execute(request: request)
    }
    
    public func requestSendCoin(
        request: App2AppSendCoinRequest
    ) async throws -> App2AppSendCoinResponse {
        return try await requestSendCoinUseCase.execute(request: request)
    }
    
    public func requestExecuteContract(
        request: App2AppExecuteContractRequest
    ) async throws -> App2AppExecuteContractResponse {
        return try await requestExecuteContractUseCase.execute(request: request)
    }
    
    public func requestExecuteContractWithEncoded(
        request: App2AppExecuteContractRequest
    ) async throws -> App2AppExecuteContractResponse {
        return try await requestExecuteContractUseCase.execute(request: request)
    }
    
    public func execute(
        requestId: String
    ) {
        executeUseCase.execute(requestId: requestId)
    }
    
    
    public func receipt(
        requestId: String
    ) async throws -> App2AppReceiptResponse {
        return try await receiptUseCase.execute(requestId: requestId)
    }
    
    
}
