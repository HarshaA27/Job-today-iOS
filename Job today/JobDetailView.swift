import SwiftUI


struct JobDetailView: View {
    
    let job: Job
    
    @ObservedObject var viewModel: JobsViewModel
    
    @State private var showEdit = false
    @State private var showDeleteAlert = false
    
    
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        
        ScrollView {
            
            VStack(alignment: .leading, spacing: 22) {
                
                
                // Customer Name
                
                Text(job.customerName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                
                StatusPill(job: job)
                
                
                Divider()
                
                
                // Address
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Address")
                        .font(.headline)
                    
                    HStack {
                        
                        Image(systemName: "location.fill")
                            .foregroundColor(.blue)
                        
                        Text(job.displayAddress)
                    }
                }
                
                
                // Schedule
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Scheduled Time")
                        .font(.headline)
                    
                    HStack {
                        
                        Image(systemName: "clock.fill")
                            .foregroundColor(.orange)
                        
                        Text(job.scheduled_at)
                    }
                }
                
                
                // Notes
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Notes")
                        .font(.headline)
                    
                    Text(
                        job.notes?.isEmpty == false
                        ? job.notes!
                        : "No notes available"
                    )
                    .foregroundColor(.secondary)
                }
                
                
                Spacer()
                
                
                // Complete Button
                
                Button {
                    
                    viewModel.markCompleted(job)
                    
                } label: {
                    
                    Text(
                        job.status == "completed"
                        ? "Completed"
                        : "Mark as Completed"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        job.status == "completed"
                        ? Color.gray
                        : Color.green
                    )
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(job.status == "completed")
                
                
                // Edit Button
                
                Button {
                    
                    showEdit = true
                    
                } label: {
                    
                    Text("Edit Job")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                
                // Delete Button
                
                Button {
                    
                    showDeleteAlert = true
                    
                } label: {
                    
                    Text("Delete Job")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationTitle("Job Details")
        .navigationBarTitleDisplayMode(.inline)
        
        
        // Edit Sheet
        
        .sheet(isPresented: $showEdit) {
            
            EditJobView(
                viewModel: viewModel,
                job: job
            )
        }
        
        
        // Delete Alert
        
        .alert(
            "Delete Job?",
            isPresented: $showDeleteAlert
        ) {
            
            Button(
                "Delete",
                role: .destructive
            ) {
                
                viewModel.deleteJob(job)
                dismiss()
            }
            
            
            Button(
                "Cancel",
                role: .cancel
            ) {}
            
        } message: {
            
            Text("This job will be removed permanently.")
        }
    }
}


#Preview {
    JobDetailView(
        job: Job(
            id: "1",
            customer_name: "Ravi Kumar",
            address: "Chennai",
            scheduled_at: "2026-11-25 09:30",
            status: "pending",
            notes: "Repair"
        ),
        viewModel: JobsViewModel()
    )
}
