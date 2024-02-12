//
//  ViewController.swift
//  HttpThing
//
//  Created by Nikita Hasan Kafes on 09.02.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //Methodun cikitisini veren label
    @IBOutlet weak var methodLabel: UILabel!
    //Status Codeun cikitisini veren label
    @IBOutlet weak var statusCodeLabel: UILabel!
    //Bastigimizda bize istenilen sonucu veren button
    @IBAction func taskButton(_ sender: UIButton) {
        statusCodeLabel.text = statCode
        methodLabel.text = reqMethod
    }
    
    let url = "https://sandbox.paratim.com/dealer"
    
    var statCode = String()
    var reqMethod = String()
    
    
    // Istegimizi gerceklestirmesi icin fonksiyon yaratiyoruz
    func performRequest(with urlString: String){
        //1. Girdi  olarak aldigimiz urlString'i URL'e donusturuyor
        if let url = URL(string: urlString){
            //2. Linke bagli default bir request olusturuyoruz
            let request = URLRequest(url: url)
            // request.httpMethod = "PUT" seklinde method belirtebiliyoruz
            //3. fonksiyon icinde olusan veriyi disa aktarmak icin onceden yarattigimiz reqMethod degiskenine requestin methodunu veriyoruz
            reqMethod = request.httpMethod!
            //4.Session'umuzu baslatiyoruz
            let session = URLSession(configuration: .default)
            
            //5. Session'a gorevi olacak taski iletiyoruz
            
            let task = session.dataTask(with: request) { data, response, error in
                
                if error != nil {
                    print("Error")
                    if let httpResponse = response as? HTTPURLResponse {
                        self.statCode = "Status Code: \(httpResponse.statusCode)"
                    }
                    return
                } else if let httpResponse = response as? HTTPURLResponse {
                    self.statCode = "Status Code: \(httpResponse.statusCode)"
                }
                
            }
            
            //6. Taski baslatiyoruz
            task.resume()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //View yuklenme asamasinda fonksiyonumuzu calistiriyoruz
        performRequest(with: url)
    }
}

