//
//  HomeView.swift
//  AleoWorkshop
//
//  Created by Nafeh Shoaib on 11/15/23.
//

import SwiftUI

import SwiftDate

struct HomeView: View {
    var name = "Gundeep"
    
    var shareRequests: [ShareRequest] = [
        ShareRequest(source: "Metamask", date: Date()),
        ShareRequest(source: "Trust Wallet", date: Date()),
        ShareRequest(source: "Aleo", date: Date()),
    ]
    
    @State var selectedRequest: ShareRequest?
    @State var text = ""
    @State private var isTooltipVisible = true
    @State private var proofKYC = false
    @State private var proveOFACClear = false
    @State private var proof1ETH = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                
                TextField("Enter Wallet Address Here", text: $text)
                    .padding()
                    .border(Color.gray, width: 0.5)
                    .overlay(alignment: .topTrailing) {
                        Group {
                            if isTooltipVisible {
                                Text("Your wallet address will never leave the device")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundStyle(Color.black)
                                    .offset(y: 50)
                            }
                        }
                    }

            }
            Toggle("Proof OFAC Clear", isOn: $proofKYC)
                .toggleStyle(CheckboxToggleStyle())
                .padding()
                .offset(CGSize(width: 0.0, height: 35.0))
            Toggle("Proof KYC done", isOn: $proveOFACClear)
                .toggleStyle(CheckboxToggleStyle())
                .padding()
                .offset(CGSize(width: 0.0, height: 10.0))

            List {
                ForEach(shareRequests) { request in
                    Button {
                        selectedRequest = request
                    } label: {
                        Text("Create Proof for \(request.source)")
                    }
                }
                .onDelete(perform: deleteRequest)
                .sheet(item: $selectedRequest) { request in
                    RequestView(shareRequest: request)
                }
            }
            .navigationTitle("iClear - Gundeep ").background(Color.green)
        }
    }
    
    func deleteRequest(_ indexSet: IndexSet?) {
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label

            Spacer()

            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(configuration.isOn ? .green : .gray)
                .onTapGesture { configuration.isOn.toggle() }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(for: [HealthRecord.self, Diagnosis.self, Medication.self], inMemory: true)
        .environment(LocalAuthenticator())
        .environment(AleoManager())
}
