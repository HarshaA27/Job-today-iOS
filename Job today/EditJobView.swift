//
//  EditJobView.swift
//  Job today
//
//  Created by Test on 25/11/26.
//
import SwiftUI


struct EditJobView: View {
    
    @ObservedObject var viewModel: JobsViewModel
    
    let job: Job
    
    @Environment(\.dismiss) var dismiss
    
    
    @State private var customerName: String
    @State private var address: String
    @State private var time: String
    @State private var notes: String
    
    
    init(
        viewModel: JobsViewModel,
        job: Job
    ) {
        
        self.viewModel = viewModel
        self.job = job
        
        _customerName = State(
            initialValue: job.customerName
        )
        
        _address = State(
            initialValue: job.address
        )
        
        _time = State(
            initialValue: job.scheduled_at
        )
        
        _notes = State(
            initialValue: job.notes ?? ""
        )
    }
    
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                TextField(
                    "Customer Name",
                    text: $customerName
                )
                
                
                TextField(
                    "Address",
                    text: $address
                )
                
                
                TextField(
                    "Time",
                    text: $time
                )
                
                
                TextField(
                    "Notes",
                    text: $notes
                )
                
                
                Button {
                    
                    let updated = Job(
                        id: job.id,
                        customer_name: customerName,
                        address: address,
                        scheduled_at: time,
                        status: job.status,
                        notes: notes
                    )
                    
                    viewModel.updateJob(updated)
                    
                    dismiss()
                    
                } label: {
                    
                    Text("Save Changes")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("Edit Job")
        }
    }
}
