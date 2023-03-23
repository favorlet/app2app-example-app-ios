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
    
    @State var toAddress: String = "0x..."
    @State var amount: String = "100000000000000000" // 0.1 KLAY
    
    @State var contractAddress: String = "0xe34acbf6fd2bc844be302e4acc97f401f6cd6985"
    @State var abi: String = "[{\n" +
    "    \"constant\": false,\n" +
    "    \"inputs\": [\n" +
    "      {\n" +
    "        \"name\": \"_to\",\n" +
    "        \"type\": \"address\"\n" +
    "      },\n" +
    "      {\n" +
    "        \"name\": \"_value\",\n" +
    "        \"type\": \"uint256\"\n" +
    "      }\n" +
    "    ],\n" +
    "    \"name\": \"transfer\",\n" +
    "    \"outputs\": [\n" +
    "      {\n" +
    "        \"name\": \"success\",\n" +
    "        \"type\": \"bool\"\n" +
    "      }\n" +
    "    ],\n" +
    "    \"payable\": false,\n" +
    "    \"type\": \"function\"\n" +
    "  }]"
    @State var params: String = "[\"0x...\",\"100000000000000000\"]"
    @State var functionName: String = "transfer"
    @State var gasLimit: String = ""
    @State var amountForEC: String = "0"
    
    
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
                        TextField("", text: $chainId)
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
                    TextField("", text: $message)
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .background(Color.white)
                    Button(action: {
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
                    TextField("", text: $toAddress)
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .background(Color.white)
                    Text("보낼 수량 (단위: peb)")
                        .font(.system(size: 13))
                    TextField("", text: $amount)
                        .font(.system(size: 20))
                        .lineLimit(1)
                        .background(Color.white)
                    Button(action: {
                        contentViewModel.requestSendCoin(
                            chainId: self.chainId,
                            toAddress: self.toAddress,
                            amount: self.amount)
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
                
                /** 컨트랙트 실행 (executeContract) */
                VStack(alignment: .leading, spacing: 10) {
                    Text("컨트랙트 실행 (executeContract)")
                        .font(.system(size: 17))
                        .bold()
                    Group {
                        Text("컨트랙트 주소")
                            .font(.system(size: 13))
                        TextField("", text: $contractAddress)
                            .font(.system(size: 20))
                            .lineLimit(1)
                            .background(Color.white)
                    }
                    Group {
                        Text("ABI")
                            .font(.system(size: 13))
                        TextField("", text: $abi, axis: .vertical)
                            .font(.system(size: 20))
                            .lineLimit(10)
                            .background(Color.white)
                    }
                    Group {
                        Text("파라미터")
                            .font(.system(size: 13))
                        TextField("", text: $params, axis: .vertical)
                            .font(.system(size: 20))
                            .lineLimit(10)
                            .background(Color.white)
                    }
                    Group {
                        Text("함수명")
                            .font(.system(size: 13))
                        TextField("", text: $functionName)
                            .font(.system(size: 20))
                            .background(Color.white)
                    }
                    Group {
                        Text("수량 (단위: peb)")
                            .font(.system(size: 13))
                        TextField("", text: $amountForEC)
                            .font(.system(size: 20))
                            .background(Color.white)
                    }
                    Group {
                        Text("가스 한도 (Optional)")
                            .font(.system(size: 13))
                        TextField("", text: $gasLimit)
                            .font(.system(size: 20))
                            .background(Color.white)
                    }
                    Button(action: {
                        self.params = "[\"\(contentViewModel.connectedAddress)\",\"0x1707Cc19778A773c45C1EA03f62482481d3c0fBD\",\"10\"]"
                        var convertedGasLimit: String? = (gasLimit != "") ? gasLimit : nil
                        contentViewModel.requestExecuteContract(
                            chainId: self.chainId,
                            contractAddress: self.contractAddress,
                            abi: self.abi,
                            params: self.params,
                            value: self.amountForEC,
                            functionName: self.functionName,
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
