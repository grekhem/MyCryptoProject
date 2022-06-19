import Foundation
import UIKit

enum SignUpAssembly {
    static func buildModule() -> UIViewController {
        let router = SignUpRouter()
        let iteractor = SignUpIteractor()
        let presenter = SignUpPresenter(router: router, iteractor: iteractor)
        let controller = SignUpViewController(presenter: presenter)
        router.vc = controller
        return controller
    }
}
