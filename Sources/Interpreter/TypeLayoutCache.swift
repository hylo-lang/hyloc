import IR
import FrontEnd
import Utils

struct TypeLayoutCache {

  let p: TypedProgram
  let abi: any TargetABI

  private typealias Storage = [AnyType: TypeLayout]
  private var storage: Storage

  subscript(_ t: AnyType) -> TypeLayout {
    mutating get {
      if let r = storage[t] { return r }
      let r = computeLayout(t)
      storage[t] = r
      return r
    }
  }

  private func offset(appending suffix: TypeLayout.Bytes, to x: TypeLayout.Bytes) -> Int {
  }

  private mutating func computeLayout(_ t: AnyType) -> TypeLayout {
    switch t.base {
    case let u as UnionType:
      let basis = u.elements.map { self[$0] }
      let discriminator = abi.unionDiscriminator(count: basis.count)
      let alignment = max(basis.lazy.map(\.alignment).max()!, self[discriminator].alignment)
      let payloadSize = basis.lazy.map(\.size).max()!
      let discriminatorOffset = 1
      fatalError()
    default:
      fatalError()
    }
    let a = AbstractTypeLayout(of: t, definedIn: p)
    fatalError()
  }
}
