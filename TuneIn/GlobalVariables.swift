//
//  GlobalVariables & Functions.swift
//  TuneIN
// 
//  Created by Lindsay Penkrat on 5/7/21.
//

import Foundation


var gblpartyUser: PartyUser!

func setPartyUser(PartyUser: PartyUser){
gblpartyUser = PartyUser
}

let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter
}()


