//
//  App2AppApi.swift
//  App2AppExample
//
//  Created by evahpirazzi on 2022/11/28.
//

import Foundation

class App2AppApi: AlamofireManager {
    
    init() {
//        super.init(baseUrl: "https://bridge.favorlet.link")
        super.init(baseUrl: "https://xbsjfedu2dfxcikdzlws2yxdhu0vaufm.lambda-url.ap-northeast-2.on.aws")
    }
    
    func requestConnectWallet(
        request: App2AppConnectWalletRequest
    ) async throws -> App2AppConnectWalletResponse {
        try await withCheckedThrowingContinuation { continuation in
            dump(request)
            requestApp2AppApi(
                url: "/request",
                method: .post,
                parameters: request.convertParams()
            )
            .responseDecodable(of: App2AppConnectWalletResponse.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    continuation.resume(returning: data)
                case .failure(let error):
                    dump(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func requestConnectWalletAndSignMessage(
        request: App2AppConnectWalletAndSignMessageRequest
    ) async throws -> App2AppConnectWalletAndSignMessageResponse {
        try await withCheckedThrowingContinuation { continuation in
            dump(request)
            requestApp2AppApi(
                url: "/request",
                method: .post,
                parameters: request.convertParams()
            )
            .responseDecodable(of: App2AppConnectWalletAndSignMessageResponse.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    continuation.resume(returning: data)
                case .failure(let error):
                    dump(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func requestSignMessage(
        request: App2AppSignMessageRequest
    ) async throws -> App2AppSignMessageResponse {
        try await withCheckedThrowingContinuation { continuation in
            dump(request)
            requestApp2AppApi(
                url: "/request",
                method: .post,
                parameters: request.convertParams()
            )
            .responseDecodable(of: App2AppSignMessageResponse.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    continuation.resume(returning: data)
                case .failure(let error):
                    dump(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func requestSendCoin(
        request: App2AppSendCoinRequest
    ) async throws -> App2AppSendCoinResponse {
        try await withCheckedThrowingContinuation { continuation in
            dump(request)
            requestApp2AppApi(
                url: "/request",
                method: .post,
                parameters: request.convertParams()
            )
            .responseDecodable(of: App2AppSendCoinResponse.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    continuation.resume(returning: data)
                case .failure(let error):
                    dump(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func requestExecuteContract(
        request: App2AppExecuteContractRequest
    ) async throws -> App2AppExecuteContractResponse {
        try await withCheckedThrowingContinuation { continuation in
            dump(request)
            requestApp2AppApi(
                url: "/request",
                method: .post,
                parameters: request.convertParams()
            )
            .responseDecodable(of: App2AppExecuteContractResponse.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    continuation.resume(returning: data)
                case .failure(let error):
                    dump(error)
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func requestReceipt(
        requestId: String
    ) async throws -> App2AppReceiptResponse {
        try await withCheckedThrowingContinuation { continuation in
            dump(requestId)
            requestApp2AppApi(
                url: "/receipt?requestId=\(requestId)",
                method: .get
            )
            .responseDecodable(of: App2AppReceiptResponse.self) { response in
                switch response.result {
                case .success(let data):
                    dump(data)
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
                
            }
        }
    }
}
