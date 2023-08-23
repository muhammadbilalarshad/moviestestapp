import Foundation
import UIKit

struct Constants{
    
    static let BaseURL                                        = "https://stagingapi.mobitalk.app/api"
    static let AccessToken                                    = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIyN2VmYTNmMDI5ZGQ0YmYyNjg0MGFiNTc5NzI4N2EwMSIsInN1YiI6IjY0ZTY4NjE0MWZlYWMxMDBlMTY4ZTkzZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MieRI5_VUx6P4hGKVujcq1YlCi4IYhrzeTGnSBha3Cc"
}

struct ApiErrorMessage {
    static let NoNetwork = NSLocalizedString("No internet connection!", comment: "")
    static let TimeOut = NSLocalizedString("Connection Timeout.", comment: "")
    static let ErrorOccured = NSLocalizedString("An error occurred. Please check your internet connection.", comment: "")
    static let BadRequest = NSLocalizedString("Bad Request.", comment: "")
    static let SOMETHING_WRONG = NSLocalizedString("Something went wrong.", comment: "")
    static let SESSION_EXPIRED = NSLocalizedString("Your session has expired because your account is being used on another device", comment: "")
    static let BLOCKED = NSLocalizedString("Your have been temporarily blocked", comment: "")
}
