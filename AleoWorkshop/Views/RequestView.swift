//
//  RequestView.swift
//  AleoWorkshop
//
//  Created by Nafeh Shoaib on 11/15/23.
//  Modified by Gundeep SIngh

import SwiftUI
import SwiftData

import Aleo

struct RequestView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(AleoManager.self) var aleoManager
    @Environment(LocalAuthenticator.self) var authenticator
    @Environment(\.presentationMode) var presentationMode
    
    @State var cloudService = iClearCloudService(serverURL: .development)

    @Query private var records: [HealthRecord]
    
    var shareRequest: ShareRequest
    
    @State var signature: Signature?
    
    @State var showSuccess: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("""
                \(shareRequest.source)
                """)
                .font(.custom("Noteworthy-Light", size: 20))
                .bold()
                Spacer()
                Button("Generate ZK Proof") {
                    signature = aleoManager.encrypt(healthRecord: records.first)
                }.background(Color.yellow)
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .navigationTitle("Share Proof of OFAC Clear").font(.custom("Noteworthy-Light", size: 20)).underline()
            .font(.custom("Noteworthy-Light", size: 20))
            .bold()
            .sheet(item: $signature, content: { signature in
                SignatureView(source: shareRequest.source, signature: signature)

            })
        }
    }
}


#Preview {
    RequestView(shareRequest: ShareRequest(source: "Metamask", date: Date()))
        .environment(LocalAuthenticator())
        .environment(AleoManager())
}
