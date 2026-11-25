//
//  AddJobView.swift
//  Job today
//
//  Created by Test on 25/11/26.
//
import SwiftUI


struct AddJobView: View {
    
    @ObservedObject var viewModel: JobsViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var customerName = ""
    @State private var address = ""
    @State private var time = ""
    @State private var notes = ""
    
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Customer Details") {
                    
                    TextField(
                        "Customer name",
                        text: $customerName
                    )
                    
                    TextField(
                        "Address",
                        text: $address
                    )
                }
                
                
                Section("Schedule") {
                    
                    TextField(
                        "Date & Time",
                        text: $time
                    )
                }
                
                
                Section("Notes") {
                    
                    TextField(
                        "Notes",
                        text: $notes
                    )
                }
                
                
                Button {
                    
                    let newJob = Job(
                        id: UUID().uuidString,
                        customer_name: customerName,
                        address: address,
                        scheduled_at: time,
                        status: "pending",
                        notes: notes
                    )
                    
                    viewModel.jobs.append(newJob)
                    
                    dismiss()
                    
                } label: {
                    
                    Text("Add Job")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("New Job")
        }
    }
}
