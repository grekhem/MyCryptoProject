import Foundation
import UIKit

enum AuthorizationAssembly {
    static func buildModule() -> UIViewController {
        let router = AuthorizationRouter()
        let iteractor = AuthorizationIteractor()
        let presenter = AuthorizationPresenter(router: router, iteractor: iteractor)
        let controller = AuthorizationViewController(presenter: presenter)
        router.vc = controller
        return controller
    }
}
