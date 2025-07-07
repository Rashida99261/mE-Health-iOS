//
//  LocalJson.swift
//  mE Health
//
//  Created by Ishant Tiwari on 01/07/25.
//

import Foundation

class ReadDataallergyIntolerances: ObservableObject  {
   
    @Published var allergy: [AllergyDummyData] = []
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "allergy_intolerance", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(AllergyResponse.self, from: data)
            DispatchQueue.main.async {
                self.allergy = decodedResponse.allergyIntolerances
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
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
   
    @Published var immune: [ImmuneDummyData] = []
    
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "immunization", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(ImmuneResponse.self, from: data)
            DispatchQueue.main.async {
                self.immune = decodedResponse.immunizations
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
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
   
    @Published var practitioners: [PractitionerData] = []
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "practitioner", withExtension: "json") else {
            print("JSON file not found")
            return
        }

        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(PractitionerResponse.self, from: data)
            DispatchQueue.main.async {
                self.practitioners = decodedResponse.practitioners
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
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
   
    @Published var procedures: [ProcedureDummyData] = []
      
    init(){
        loadData()
    }
    
    func loadData()  {
        guard let url = Bundle.main.url(forResource: "procedure", withExtension: "json")
            else {
                print("Json file not found")
                return
            }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(ProcedureJsonResponse.self, from: data)
            DispatchQueue.main.async {
                self.procedures = decodedResponse.procedures
                print(self.procedures)
            }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
     
}
