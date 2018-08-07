//
//  Паттерн внедрения зависимостей
//

import Swinject
import XCTest
@testable import e_bizhanov

// Необязательно делать замыкание,
// т.к. переменная уже по факту является ленивой (объявлена глобально)

/// Сборщик модулей
private let assembler: Assembler = Assembler(
    [
        ServiceAssembler(),
        AuthServiceAssembler(),
        CatalogServiceAssembler(),
        ReviewsServiceAssembler(),
        BasketServiceAssembler()
    ]
)

extension XCTestCase {
    var resolver: Resolver {
       return assembler.resolver
    }
}
