import UIKit
import Alamofire
import SwiftyJSON


class APIManagerBase: NSObject
{
    var alamoFireManager : SessionManager!
    let baseURL = Constants.BaseURL
    let defaultRequestHeader = ["Content-Type": "application/json"]
    let defaultError = NSError(domain: "ACError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Request Failed."])
    
    override init() {
        
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 25
        configuration.timeoutIntervalForResource = 25
        alamoFireManager = Alamofire.SessionManager.init(configuration: configuration)
        
    }
    
    func getAuthorizationHeader () -> Dictionary<String,String>{
        
        return ["Authorization":"Bearer " + Constants.AccessToken,"Accept":"application/json","Content-Type":"application/json"]
    }
    

    func GETURLfor(route:String, parameters: Parameters) -> URL?{
        var queryParameters = ""
        for key in parameters.keys {
            if queryParameters.isEmpty {
                queryParameters =  "?\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            } else {
                queryParameters +=  "&\(key)=\((String(describing: (parameters[key]!))).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)"
            }
            queryParameters =  queryParameters.trimmingCharacters(in: .whitespaces)
            
        }
        if let components: NSURLComponents = NSURLComponents(string: (Constants.BaseURL+route+queryParameters)){
            return components.url! as URL
        }
        return nil
    }
    
    
    func showErrorMessage(error: Error)
    {
        
        if (error as NSError).code == -1009
        {
            Utility.showErrorWith(message: ApiErrorMessage.NoNetwork)
            
        }
        else
        {
            Utility.showErrorWith(message:(error as NSError).localizedDescription)
        }
        
        
        switch (error as NSError).code {
        case -1001:
            Utility.showErrorWith(message: ApiErrorMessage.TimeOut)
        case -1009:
            Utility.showErrorWith(message: ApiErrorMessage.NoNetwork)
        case 4:// Api Call Error
            Utility.showErrorWith(message: ApiErrorMessage.BadRequest)
        case -1005:
            Utility.showErrorWith(message: ApiErrorMessage.NoNetwork)
        default:
            Utility.showErrorWith(message: (error as NSError).localizedDescription)
        }
    }
    
    
    func getRequestWith(route: URL,parameters: Parameters,
                        success:@escaping DefaultArrayResultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure,
                        errorPopup: Bool){
        
        
        
        alamoFireManager.request(route, method: .get, encoding: JSONEncoding.prettyPrinted, headers: getAuthorizationHeader()).responseJSON{
            response in
            
            
            guard response.result.error == nil else{
                
                print("error in calling get request")
                if errorPopup {self.showErrorMessage(error: response.result.error!)}
                failure(response.result.error! as NSError)
                
                return;
            }
            
            
            if response.result.isSuccess {
                if let jsonResponse = response.result.value as? Dictionary<String, AnyObject>{
                    
                    success(jsonResponse)
                } else {
                    success(Dictionary<String, AnyObject>())
                }
            }
            
            
            
        }
        
    }
    
}

public extension Data {
    var mimeType:String {
        get {
            var c = [UInt32](repeating: 0, count: 1)
            (self as NSData).getBytes(&c, length: 1)
            switch (c[0]) {
            case 0xFF:
                return "image/jpeg";
            case 0x89:
                return "image/png";
            case 0x47:
                return "image/gif";
            case 0x49, 0x4D:
                return "image/tiff";
            case 0x25:
                return "application/pdf";
            case 0xD0:
                return "application/vnd";
            case 0x46:
                return "text/plain";
            default:
                print("mimeType for \(c[0]) in available");
                return "application/octet-stream";
            }
        }
    }
}



