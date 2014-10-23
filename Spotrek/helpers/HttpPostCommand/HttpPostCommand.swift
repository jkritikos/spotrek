//
//  HttpSessionPostCommand.swift
//  myFirstSwiftApp
//
//  Created by Yannis Belessiotis on 10/22/14.
//  Copyright (c) 2014 Boomar.gr. All rights reserved.
//






import Foundation

class HttpPostCommand {
    
    var delegate:HttpPostCommandDelegate?
    var commandUrlKey:CommandUrlKey!

    private var request: NSMutableURLRequest!
    private var session:NSURLSession!
    private var url:String!
    private var params:Dictionary<String,String>!
    
    
    init (params:Dictionary<String,String>, commandUrlKey:CommandUrlKey!){

        self.params = params
        self.url  =  commandUrlKey!.rawValue
        self.commandUrlKey = commandUrlKey
        request = NSMutableURLRequest(URL: NSURL(string:url)!)
        request.HTTPMethod = "POST"
        session = NSURLSession.sharedSession()
        var inputString:String! = ""
        var i : Int! = 1
        var value:String!
        for key  in params.keys {
            value = params[key]
            inputString = inputString +  "\(key)=\(value)"
            
            if i < params.count {
            
                inputString = inputString + "&"
            }
            i = i + 1
        }
        request.HTTPBody = inputString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
    }
    
    
    func execute(){
    
        var task = session.dataTaskWithRequest(request, completionHandler: { (data:NSData! , response: NSURLResponse! , error: NSError!) -> Void in
            
            var callError:SimpleError?
            var json:NSDictionary?
            
            if error != nil {
                
                callError = SimpleError(code:"0", message: error.localizedDescription)
                
                
            }else {
                
                var err: NSError?
                //Create a dictionary from response Data
                json = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error: &err) as? NSDictionary
                if(err != nil) {
                    
                    callError = SimpleError(code:"1", message:err?.localizedDescription)
                    
                }
                    
                else {
                    
                    if json != nil {
                        
                        let respData:NSDictionary? = json?.objectForKey("data") as? NSDictionary
                        var responseStatus: Int! = respData?.objectForKey("response")?.integerValue
                        
                        switch responseStatus {
                            
                        case 1000:
                            
                            callError = nil
                            
                        case -1:
                            
                            callError = SimpleError(code:"-1",message: "RESPONSE_ERROR")
                            
                        case -2:
                            
                            callError = SimpleError(code:"-2",message: "ERROR_UNAUTHORISED")
                            
                        case -3:
                            callError = SimpleError(code:"-3",message: "ERROR_INVALID_INPUT")
                            
                        default:
                            callError = SimpleError(code:"2",message: "UKNOWN_ERROR")
                            
                        }
                        
                    }else{
                        
                        callError = SimpleError(code:"3", message:"EMPTY_RESPONSE")
                        
                    }
                    
                }
            }
           
            
            if callError != nil {
                

                self.delegate?.commandFailedWithError(callError, commandUrlKey :self.commandUrlKey )
                
            }else{
                
                if json != nil {

                    
                    self.delegate?.commandCompletedSuccessfully(json, commandUrlKey: self.commandUrlKey)
                    
                }
            }
            
        })
    

        task.resume()
    
    }
    
}


