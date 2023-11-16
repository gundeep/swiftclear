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
    @State private var isTooltipVisible = false

    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(shareRequests) { request in
                    Button {
                        selectedRequest = request
                    } label: {
                        Text("Request from \(request.source) at \(request.date, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    }
                }
                .onDelete(perform: deleteRequest)
                .sheet(item: $selectedRequest) { request in
                    RequestView(shareRequest: request)
                }
            }
            .navigationTitle("Welcome \(name)!")
        }
        
        VStack {
            TextField("Enter Wallet Address Here", text: $text)
                .padding()
                .border(Color.gray, width: 0.5)
                .gesture(LongPressGesture(minimumDuration: 0.5)
                    .onChanged { _ in isTooltipVisible = true }
                    .onEnded { _ in isTooltipVisible = false })
                .overlay(
                    Group {
                        if isTooltipVisible {
                            Text("Your wallet address will never leave the device")
                                .padding()
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .shadow(radius: 5)
                                .offset(y: -50)
                        }
                    }, alignment: .topTrailing
                )
        }
        // write code input field to view
        //
         //let textField = UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
         //textField.borderStyle = UITextField.BorderStyle.roundedRect
         //textField.placeholder = "Enter text here"
        //
        //


        //self.view.addSubview(textField)
    }
    


    func deleteRequest(_ indexSet: IndexSet?) {
        
    }
    
}

#Preview {
    HomeView()
        .modelContainer(for: [HealthRecord.self, Diagnosis.self, Medication.self], inMemory: true)
        .environment(LocalAuthenticator())
        .environment(AleoManager())
}
