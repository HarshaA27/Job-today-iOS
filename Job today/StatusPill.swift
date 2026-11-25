import SwiftUI


struct StatusPill: View {
    
    let job: Job
    
    
    var title: String {
        
        if job.isOverdue {
            return "Overdue"
        }
        
        switch job.status {
            
        case "completed":
            return "Completed"
            
        case "in_progress":
            return "In Progress"
            
        default:
            return "Pending"
        }
    }
    
    
    var pillColor: Color {
        
        if job.isOverdue {
            return .red
        }
        
        switch job.status {
            
        case "completed":
            return .green
            
        case "in_progress":
            return .blue
            
        default:
            return .orange
        }
    }
    
    
    var body: some View {
        
        Text(title)
            .font(.caption)
            .fontWeight(.semibold)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(pillColor.opacity(0.2))
            .foregroundColor(pillColor)
            .clipShape(Capsule())
    }
}
