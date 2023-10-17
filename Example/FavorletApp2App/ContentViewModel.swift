//
//  ContentViewModel.swift
//  FavorletApp2App_Example
//
//  Created by evahpirazzi on 2022/12/08.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import FavorletApp2App


class ContentViewModel: ObservableObject {
    
    private let app2AppComponent = App2AppComponent()
    
    @Published var app2appRequestId: String = ""
    @Published var connectedAddress: String = ""
    @Published var signatureHash: String = ""
    @Published var resultSendCoin: String = ""
    @Published var resultExecuteContract: String = ""
    @Published var resultExecuteContractWithEncoded: String = ""
    
    @Published var isProgress: Bool = false
    @Published var isConnectedWallet: Bool = false
    @Published var receivedChainId: Int = -1
    
    @Published var errorToast: String = ""
    
    private var blockChainApp = App2AppBlockChainApp(
        name: "App2App Example",
        successAppLink: nil,
        failAppLink: nil
    )
    
    func requestConnectWallet(chainId: String) {
        Task {
            do {
                guard let chainId = Int(chainId) else {
                    return
                }
                
                await MainActor.run { self.isProgress = true }
                
                let response = try await self.app2AppComponent.requestConnectWallet(
                    request: App2AppConnectWalletRequest(
                        action: App2AppAction.CONNECT_WALLET.rawValue,
                        chainId: chainId,
                        blockChainApp: self.blockChainApp
                    )
                )
                await MainActor.run {
                    self.isProgress = false
                    self.app2appRequestId = response.requestId ?? ""
                }
            } catch {
                await MainActor.run { self.isProgress = false }
            }
        }
    }
    
    func requestConnectWalletAndSignMessage(chainId: String, message: String) {
        Task {
            do {
                guard let chainId = Int(chainId) else {
                    return
                }
                
                await MainActor.run { self.isProgress = true }
                
                let response = try await app2AppComponent.requestConnectWalletAndSignMessage(
                    request: App2AppConnectWalletAndSignMessageRequest(
                        action: App2AppAction.CONNECT_WALLET_AND_SIGN_MESSAGE.rawValue,
                        chainId: chainId,
                        blockChainApp: self.blockChainApp,
                        connectWalletAndSignMessage: App2AppConnectWalletAndSignMessage(
                            value: message
                        )
                    )
                )
                await MainActor.run {
                    self.isProgress = false
                    self.app2appRequestId = response.requestId ?? ""
                }
            } catch {
                await MainActor.run { self.isProgress = false }
            }
        }
    }
    
    func requestSignMessage(chainId: String, message: String) {
        Task {
            do {
                await MainActor.run { self.isProgress = true }
                
                let response = try await app2AppComponent.requestSignMessage(
                    request: App2AppSignMessageRequest(
                        action: App2AppAction.SIGN_MESSAGE.rawValue,
                        chainId: Int(chainId) ?? 0,
                        blockChainApp: self.blockChainApp,
                        signMessage: App2AppSignMessage(
                            from: connectedAddress,
                            value: message
                        )
                    )
                )
                await MainActor.run {
                    self.isProgress = false
                    self.app2appRequestId = response.requestId ?? ""
                }
            } catch {
                await MainActor.run { self.isProgress = false }
            }
        }
    }
    
    func requestSendCoin(chainId: String, toAddress: String, amount: String) {
        Task {
            do {
                await MainActor.run { self.isProgress = true }
            
                let response = try await app2AppComponent.requestSendCoin(
                    request: App2AppSendCoinRequest(
                        action: App2AppAction.SEND_COIN.rawValue,
                        chainId: Int(chainId) ?? 0,
                        blockChainApp: self.blockChainApp,
                        transactions: [
                            App2AppTransaction(
                                from: self.connectedAddress,
                                to: toAddress,
                                value: amount
                            )
                        ]
                    )
                )
                await MainActor.run {
                    self.isProgress = false
                    self.app2appRequestId = response.requestId ?? ""
                }
            } catch {
                await MainActor.run { self.isProgress = false }
            }
        }
    }
    
    func requestExecuteContractWithEncoded(
        chainId: String,
        contractAddress: String,
        value: String,
        data: String,
        gasLimit: String? = nil
    ) {
        Task {
            do {
                await MainActor.run { self.isProgress = true }
                
                let response = try await app2AppComponent.requestExecuteContractWithEncoded(
                    request: App2AppExecuteContractRequest(
                        action: App2AppAction.EXECUTE_CONTRACT_WITH_ENCODED.rawValue,
                        chainId: Int(chainId) ?? 0,
                        blockChainApp: self.blockChainApp,
                        transactions: [
                            App2AppTransaction(
                                from: self.connectedAddress,
                                contract: contractAddress,
                                value: value,
                                data: data,
                                gasLimit: gasLimit
                            )
                        ]
                    )
                )
                await MainActor.run {
                    self.isProgress = false
                    self.app2appRequestId = response.requestId ?? ""
                }
            } catch {
                await MainActor.run { self.isProgress = false }
            }
        }
    }
    
    
    func execute(requestId: String) {
        app2AppComponent.execute(requestId: requestId)
    }
    
    
    func requestReceipt() {
        guard app2appRequestId != "" else {
            return
        }
        Task {
            do {
                await MainActor.run { self.isProgress = true }
                let response = try await app2AppComponent.receipt(requestId: app2appRequestId)
                
                await MainActor.run {
                    self.isProgress = false
                    app2appRequestId = ""
                    
                    switch response.action {
                    case App2AppAction.CONNECT_WALLET.rawValue:
                        connectedAddress = response.connectWallet?.address ?? ""
                        isConnectedWallet = (connectedAddress != "")
                        guard let chainId = response.chainId else {
                            break
                        }
                        receivedChainId = chainId
                        
                    case App2AppAction.CONNECT_WALLET_AND_SIGN_MESSAGE.rawValue:
                        connectedAddress = response.connectWalletAndSignMessage?.address ?? ""
                        signatureHash = response.connectWalletAndSignMessage?.signature ?? ""
                        
                    case App2AppAction.SIGN_MESSAGE.rawValue:
                        signatureHash = response.signMessage?.signature ?? ""
                        
                    case App2AppAction.SEND_COIN.rawValue:
                        resultSendCoin = response.transactions?.first?.status ?? ""
                        
                        // MARK: 1.0.1 이하만 지원
//                    case App2AppAction.EXECUTE_CONTRACT.rawValue:
//                        resultExecuteContract = response.transactions?.first?.status ?? ""
                        
                    case App2AppAction.EXECUTE_CONTRACT_WITH_ENCODED.rawValue:
                        resultExecuteContractWithEncoded = response.transactions?.first?.status ?? ""
                        
                    default:
                        isProgress = false
                    }
                }
            } catch {
                await MainActor.run { self.isProgress = false }
            }
        }
    }
    
}

