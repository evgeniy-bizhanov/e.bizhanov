//
//
//

protocol AbstractContainer {
    typealias Initializer = (Resolver) throws -> Any
    
    @discardableResult
    func register(_ service: Any.Type, factory: @escaping Initializer) -> Result<Container>
}
