import Foundation
import Combine


class JobsViewModel: ObservableObject {
    
    
    @Published var jobs: [Job] = []
    @Published var searchText = ""
    @Published var showPendingOnly = false
    
    
    init() {
        loadJobs()
    }
    
    
    func loadJobs() {
        jobs = JobLoader.loadJobs()
    }
    
    
    var filteredJobs: [Job] {
        
        var result = jobs
        
        if showPendingOnly {
            result = result.filter {
                $0.status == "pending"
            }
        }
        
        
        if !searchText.isEmpty {
            result = result.filter {
                $0.customerName.localizedCaseInsensitiveContains(searchText)
                ||
                $0.address.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return result
    }
    
    
    var totalCount: Int {
        jobs.count
    }
    
    
    var pendingCount: Int {
        jobs.filter {
            $0.status == "pending"
        }.count
    }
    
    
    var completedCount: Int {
        jobs.filter {
            $0.status == "completed"
        }.count
    }
    
    
    func markCompleted(_ job: Job) {
        
        if let index = jobs.firstIndex(where: {
            $0.id == job.id
        }) {
            
            jobs[index].status = "completed"
        }
    }
    
    
    // ADD NEW JOB
    
    func addJob(_ job: Job) {
        jobs.append(job)
    }
    
    
    // UPDATE JOB
    
    func updateJob(_ updatedJob: Job) {
        
        if let index = jobs.firstIndex(where: {
            $0.id == updatedJob.id
        }) {
            
            jobs[index] = updatedJob
        }
    }
    
    
    // DELETE JOB
    
    func deleteJob(_ job: Job) {
        
        jobs.removeAll {
            $0.id == job.id
        }
    }
}
