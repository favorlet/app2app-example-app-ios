//
//  App2AppAction.swift
//  FavorletApp2App
//
//  Created by evahpirazzi on 2022/12/07.
//

import Foundation

@frozen
public enum App2AppAction: String {
    case CONNECT_WALLET = "connectWallet"
    case SIGN_MESSAGE = "signMessage"
    case SEND_COIN = "sendCoin"
    case EXECUTE_CONTRACT = "executeContract"
}
