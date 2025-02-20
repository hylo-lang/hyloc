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

  private mutating func computeLayout(_ t: AnyType) -> TypeLayout {
    switch t.base {
    case let u as UnionType:
      let basis = u.elements.map { self[$0] }

      let discriminator = abi.unionDiscriminator(count: basis.count)
      let discriminatorLayout = self[discriminator]

      let payloadBytes = TypeLayout.Bytes(
        alignment: basis.lazy.map(\.alignment).max()!,
        size: basis.lazy.map(\.size).max()!)

      let payloadFirst = payloadBytes.appending(discriminatorLayout.bytes)
      let discriminatorFirst = discriminatorLayout.bytes.appending(payloadBytes)

      if payloadFirst.size < discriminatorFirst.size {
        return TypeLayout.init(
          bytes: payloadFirst,
          type: t,
          components:
            basis.map { (name: nil, type: $0.type, offset: 0) }
            + [ (name: nil, type: discriminator, offset: payloadFirst.size - discriminatorLayout.size) ]
          isUnionLayout: true)
      }
      else {
        return TypeLayout.init(
          bytes: discriminatorFirst,
          type: t,
          components: basis.map { (name: nil, type: $0.type, offset: discriminatorFirst.size - payloadBytes.size) }
            + [ (name: nil, type: discriminator, offset: 0) ]
          isUnionLayout: true)

      }
    default:
      fatalError()
    }
    let a = AbstractTypeLayout(of: t, definedIn: p)
    fatalError()
  }
}
