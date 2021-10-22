//
//  TCFieldNumber.swift
//  NativeSigner
//
//  Created by Alexander Slesarev on 14.9.2021.
//

import SwiftUI

struct TCFieldNumber: View {
    var value: FieldNumber
    @State private var showDoc = false
    var body: some View {
        Button (action: {
            self.showDoc.toggle()
        }) {
            HStack {
                Text(value.number)
                    .foregroundColor(Color("textMainColor"))
                Spacer()
                if value.docs_field_number + value.path_type + value.docs_type != "" {
                    Text("?")
                        .foregroundColor(Color("AccentColor"))
                }
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("backgroundCard")/*@END_MENU_TOKEN@*/)
            if showDoc {
                VStack {
                    Text("Path: " + value.path_type)
                    Text(String(fromHexDocs: value.docs_field_number) ?? "docs parsing error in iOS, please refer to other sources")
                        .foregroundColor(Color("textMainColor"))
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("backgroundCard")/*@END_MENU_TOKEN@*/)
                    Text(String(fromHexDocs: value.docs_type) ?? "docs parsing error in iOS, please refer to other sources")
                        .foregroundColor(Color("textMainColor"))
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("backgroundCard")/*@END_MENU_TOKEN@*/)
                }
            }
        }.disabled(value.docs_field_number + value.path_type + value.docs_type == "")
    }
}

/*
 struct TCFieldNumber_Previews: PreviewProvider {
 static var previews: some View {
 TCFieldNumber()
 }
 }*/
