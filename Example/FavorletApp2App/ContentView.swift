//
//  ContentView.swift
//  FavorletApp2App_Example
//
//  Created by evahpirazzi on 2022/12/08.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.openURL) var openURL
    
    @StateObject var contentViewModel = ContentViewModel()
    
    @State var chainId: String = ""
    @State var message: String = "favorlet"
    @State var toAddress: String = ""
    @State var value: String = ""
    @State var contractAddress: String = ""
    @State var data: String = ""
    @State var gasLimit: String = ""
    @State var valueForEC: String = ""
    
    
    var body: some View {
        VStack(spacing: 15) {
            HStack() {
                Spacer()
                Text("App2App Example")
                    .font(.system(size: 22))
                    .bold()
                Spacer()
            }
            .padding(.bottom, -15)
                
            ScrollView {
                
                /** 지갑연결 (connectWallet) */
                VStack(alignment: .leading, spacing: 10) {
                    Text("지갑연결 (connectWallet)")
                        .font(.system(size: 17))
                        .bold()
                    Text("체인 ID (Optional)")
                        .font(.system(size: 13))
                    HStack(spacing: 0) {
                        TextField("ex) 8217", text: $chainId)
                            .keyboardType(.numberPad)
                            .lineLimit(1)
                            .font(.system(size: 20))
                            .background(Color.white)
                            
                        Spacer()
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Klaytn Mainnet: 8217")
                            .font(.system(size: 15))
                        Text("Klaytn Testnet (Baobab): 1001")
                            .font(.system(size: 15))
                        Text("Ethereum Mainnet: 1")
                            .font(.system(size: 15))
                        Text("Ethereum Testnet (Goerli): 5")
                            .font(.system(size: 15))
                        Text("Polygon Mainnet: 137")
                            .font(.system(size: 15))
                        Text("Polygon Testnet (Mumbai): 80001")
                            .font(.system(size: 15))
                        Text("BSC Mainnet: 56")
                            .font(.system(size: 15))
                        Text("BSC Testnet: 97")
                            .font(.system(size: 15))
                    }
                    Button(action: {
                        UserDefaults.standard.setValue(chainId, forKey: Constant.CHAIN_ID.rawValue)
                        
                        contentViewModel.requestConnectWallet(
                            chainId: self.chainId
                        )
                    }) {
                        Text("연결하기")
                            .bold()
                            .padding(.top, 15)
                    }
                    Text("결과")
                        .font(.system(size: 13))
                    Text(contentViewModel.connectedAddress)
                        .font(.system(size: 15))
                        .bold()
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                
                /** 메시지 서명 (signMessage) */
                VStack(alignment: .leading, spacing: 10) {
                    Text("메시지 서명 (signMessage) ")
                        .font(.system(size: 17))
                        .bold()
                    Text("메시지 원본")
                        .font(.system(size: 13))
                    TextField("ex) favorlet", text: $message)
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .background(Color.white)
                    Button(action: {
                        UserDefaults.standard.setValue(message, forKey: Constant.MESSAGE.rawValue)
                        
                        contentViewModel.requestSignMessage(
                            chainId: self.chainId,
                            message: self.message
                        )
                    }) {
                        Text("서명하기")
                            .bold()
                            .padding(.top, 15)
                    }
                    Text("결과")
                        .font(.system(size: 13))
                    Text(contentViewModel.signatureHash)
                        .font(.system(size: 15))
                        .bold()
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .disabled(!contentViewModel.isConnectedWallet)
                
                
                /** 코인전송 (sendCoin) */
                VStack(alignment: .leading, spacing: 10) {
                    Text("코인전송 (sendCoin)")
                        .font(.system(size: 17))
                        .bold()
                    Text("받을 지갑주소")
                        .font(.system(size: 13))
                    TextField("ex) 0x{hex}", text: $toAddress)
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .background(Color.white)
                    Text("보낼 수량 (단위: peb, wei)")
                        .font(.system(size: 13))
                    TextField("ex) 1000000000000000000", text: $value)
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .background(Color.white)
                    Button(action: {
                        UserDefaults.standard.setValue(toAddress, forKey: Constant.TO_ADDRESS.rawValue)
                        UserDefaults.standard.setValue(value, forKey: Constant.VALUE.rawValue)
                        
                        contentViewModel.requestSendCoin(
                            chainId: self.chainId,
                            toAddress: self.toAddress,
                            amount: self.value)
                    }) {
                        Text("전송하기")
                            .bold()
                            .padding(.top, 15)
                    }
                    Text("결과")
                        .font(.system(size: 13))
                    Text(contentViewModel.resultSendCoin)
                        .font(.system(size: 15))
                        .bold()
                    
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .disabled(!contentViewModel.isConnectedWallet)
                
                
                /** 컨트랙트 함수 실행 (ExecuteContractWithEncoded) */
                VStack(alignment: .leading, spacing: 10) {
                    Text("컨트랙트 실행 (executeContractWithEncoded)")
                        .font(.system(size: 17))
                        .bold()
                    Group {
                        Text("컨트랙트 주소")
                            .font(.system(size: 13))
                        TextField("ex) 0x{hex}", text: $contractAddress)
                            .font(.system(size: 20))
                            .lineLimit(1)
                            .background(Color.white)
                    }
                    Group {
                        Text("인코딩된 함수데이터")
                            .font(.system(size: 13))
                        TextField("ex) 0x{hex}", text: $data, axis: .vertical)
                            .font(.system(size: 20))
                            .lineLimit(10)
                            .background(Color.white)
                    }
                    Group {
                        Text("보낼 수량 (단위: peb, wei)")
                            .font(.system(size: 13))
                        TextField("ex) 1000000000000000000", text: $valueForEC)
                            .font(.system(size: 20))
                            .lineLimit(1)
                            .background(Color.white)
                    }
                    Group {
                        Text("가스 Limit (Optional)")
                            .font(.system(size: 13))
                        TextField("", text: $gasLimit)
                            .font(.system(size: 20))
                            .background(Color.white)
                    }
                    Button(action: {
                        let convertedGasLimit: String? = (gasLimit != "") ? gasLimit : nil
                        UserDefaults.standard.setValue(contractAddress, forKey: Constant.EC_CONTRACT_ADDRESS.rawValue)
                        UserDefaults.standard.setValue(valueForEC, forKey: Constant.EC_VALUE.rawValue)
                        UserDefaults.standard.setValue(data, forKey: Constant.EC_DATA.rawValue)
                        UserDefaults.standard.setValue(gasLimit, forKey: Constant.EC_GAS_LIMIT.rawValue)
                        
                        contentViewModel.requestExecuteContractWithEncoded(
                            chainId: self.chainId,
                            contractAddress: self.contractAddress,
                            value: self.valueForEC,
                            data: self.data,
                            gasLimit: convertedGasLimit
                        )
                    }) {
                        Text("실행하기")
                            .bold()
                            .padding(.top, 15)
                    }
                    Text("결과")
                        .font(.system(size: 13))
                    Text(contentViewModel.resultExecuteContract)
                        .font(.system(size: 15))
                        .bold()
                }
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .disabled(!contentViewModel.isConnectedWallet)
            }
            .padding()
        }
        .onAppear() {
            chainId = UserDefaults.standard.string(forKey: Constant.CHAIN_ID.rawValue) ?? ""
            message = UserDefaults.standard.string(forKey: Constant.MESSAGE.rawValue) ?? "favorlet"
            toAddress = UserDefaults.standard.string(forKey: Constant.TO_ADDRESS.rawValue) ?? "0x..."
            value = UserDefaults.standard.string(forKey: Constant.VALUE.rawValue) ?? "1000000000000000000"
            contractAddress = UserDefaults.standard.string(forKey: Constant.EC_CONTRACT_ADDRESS.rawValue) ?? ""
            valueForEC = UserDefaults.standard.string(forKey: Constant.EC_VALUE.rawValue) ?? "0"
            data = UserDefaults.standard.string(forKey: Constant.EC_DATA.rawValue) ?? ""
            gasLimit = UserDefaults.standard.string(forKey: Constant.EC_GAS_LIMIT.rawValue) ?? ""
        }
        .onReceive(contentViewModel.$app2appRequestId) { requestId in
            guard requestId != "" else {
                return
            }
            dump(requestId)
            
            contentViewModel.execute(requestId: requestId)

        }
        .onReceive(contentViewModel.$receivedChainId) { chainId in
            if chainId > 0 { self.chainId = "\(chainId)" }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                contentViewModel.requestReceipt()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 0) {
            ContentView()
        }
    }
}
