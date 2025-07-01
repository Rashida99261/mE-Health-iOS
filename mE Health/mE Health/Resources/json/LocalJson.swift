//
//  LocalJson.swift
//  mE Health
//
//  Created by Ishant Tiwari on 01/07/25.
//

import Foundation

class ReadDataallergyIntolerances: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "allergy_intolerance", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDataappointment: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "appointment", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatclaim: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "claim", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatcondition: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "condition", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatdiagnostic_report: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "diagnostic_report", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatencounter: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "encounter", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatimaging_study: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "imaging_study", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDataimmunization: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "immunization", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatamedication_request: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "medication_request", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDataobservation: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "observation", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDataorganization: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "organization", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatapatient: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "patient", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatapractitioner: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "practitioner", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDatapractitioner_organization: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "practitioner_organization", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}

class ReadDataprocedure: ObservableObject  {
   
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "procedure", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        let data = try? Data(contentsOf: url)
        print(data!)
       
        
    }
     
}
