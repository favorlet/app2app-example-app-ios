//
//  RequestExecuteContractUseCase.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 2022/12/08.
//

import Foundation

class RequestExecuteContractUseCase {
    
    private let app2AppRepository = App2AppRepository()
    
    /**
     * ExecuteContract, ExecuteContractWithEncoded
     */
    func execute(
        request: App2AppExecuteContractRequest
    ) async throws -> App2AppExecuteContractResponse {
        return try await app2AppRepository.requestExecuteContract(request: request)
    }
}
