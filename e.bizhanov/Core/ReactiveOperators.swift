//
// Инфиксы операторов, для упрощения и наглядности работы с ReactiveKit
//

import Bond
import ReactiveKit

// MARK: - Operators declarations
infix operator ~        // Двусторонняя привязка
infix operator <~       // Односторонняя привязка

// MARK: - ~
@discardableResult
func ~ <T> (left: DynamicSubject<T>, right: Observable<T>) -> Disposable {
    return right.bidirectionalBind(to: left)
}

// MARK: - <~
@discardableResult
func <~ <T> (left: Bond<T>, right: Observable<T>) -> Disposable {
    return right.bind(to: left)
}

@discardableResult
func <~ <T> (left: Bond<T>, right: Signal<T, NoError>) -> Disposable {
    return left.bind(signal: right)
}

@discardableResult
func <~ <T> (left: Signal<T, NoError>, right: Observable<T>) -> Disposable {
    return left.bind(to: right)
}

// MARK: - >>
@discardableResult
func >> <T> (left: Bond<T>, right: Observable<T>) -> Disposable {
    return right.bind(to: left)
}
