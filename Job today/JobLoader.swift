import Foundation


class JobLoader {
    
    
    static func loadJobs() -> [Job] {
        
        guard let url = Bundle.main.url(
            forResource: "jobs",
            withExtension: "json"
        ) else {
            
            print("❌ jobs.json not found")
            return []
        }
        
        
        do {
            
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            
            let jobs = try decoder.decode(
                [Job].self,
                from: data
            )
            
            print("✅ Loaded jobs:", jobs.count)
            
            return jobs
            
        } catch {
            
            print("❌ JSON Error:", error)
            return []
        }
    }
}
