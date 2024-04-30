//
//  RequestConnectWalletAndSignMessageUseCase.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 10/17/23.
//

import Foundation

class RequestConnectWalletAndSignMessageUseCase {
    
    private let app2AppRepository = App2AppRepository()
    
    
    func execute(
        request: App2AppConnectWalletAndSignMessageRequest
    ) async throws -> App2AppConnectWalletAndSignMessageResponse {
        return try await app2AppRepository.requestConnectWalletAndSignMessage(request: request)
    }
    
}
