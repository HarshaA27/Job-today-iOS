import SwiftUI


struct ContentView: View {
    
    @StateObject private var viewModel = JobsViewModel()
    
    @State private var showAddJob = false
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                
                // Dashboard Cards
                
                HStack(spacing: 12) {
                    
                    DashboardCard(
                        title: "Total",
                        value: viewModel.totalCount,
                        color: .blue
                    )
                    
                    DashboardCard(
                        title: "Pending",
                        value: viewModel.pendingCount,
                        color: .orange
                    )
                    
                    DashboardCard(
                        title: "Done",
                        value: viewModel.completedCount,
                        color: .green
                    )
                }
                .padding()
                
                
                // Search
                
                TextField(
                    "Search customer or address",
                    text: $viewModel.searchText
                )
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                
                
                // Filter
                
                Picker(
                    "Filter",
                    selection: $viewModel.showPendingOnly
                ) {
                    
                    Text("All")
                        .tag(false)
                    
                    Text("Pending")
                        .tag(true)
                }
                .pickerStyle(.segmented)
                .padding()
                
                
                
                List(viewModel.filteredJobs) { job in
                    
                    NavigationLink {
                        
                        JobDetailView(
                            job: job,
                            viewModel: viewModel
                        )
                        
                    } label: {
                        
                        VStack(
                            alignment: .leading,
                            spacing: 8
                        ) {
                            
                            HStack {
                                
                                Text(job.customerName)
                                    .font(.headline)
                                
                                Spacer()
                                
                                StatusPill(job: job)
                            }
                            
                            
                            Text(job.displayAddress)
                                .foregroundColor(.secondary)
                            
                            
                            Text(job.scheduled_at)
                                .font(.caption)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(.insetGrouped)
            }
            .navigationTitle("Today's Jobs")
            
            // Add Button
            
            .toolbar {
                
                Button {
                    showAddJob = true
                    
                } label: {
                    
                    Image(systemName: "plus")
                }
            }
            
            
            .sheet(isPresented: $showAddJob) {
                
                AddJobView(
                    viewModel: viewModel
                )
            }
        }
    }
}


#Preview {
    ContentView()
}
