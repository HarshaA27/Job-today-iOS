import Foundation


struct Job: Identifiable, Codable {
    
    var id: String
    var customer_name: String?
    var address: String
    var scheduled_at: String
    var status: String
    var notes: String?
    
    
    // Customer name handling
    var customerName: String {
        customer_name ?? "Unknown customer"
    }
    
    
    // Address handling
    var displayAddress: String {
        address.isEmpty ? "No address yet" : address
    }
    
    
    // Overdue checking
    var isOverdue: Bool {
        
        guard status == "pending" else {
            return false
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let scheduledDate = formatter.date(from: scheduled_at) else {
            return false
        }
        
        return scheduledDate < Date()
    }
    
    
    // Status display name
    var displayStatus: String {
        
        if isOverdue {
            return "Overdue"
        }
        
        switch status {
            
        case "in_progress":
            return "In progress"
            
        case "completed":
            return "Completed"
            
        default:
            return "Pending"
        }
    }
}
