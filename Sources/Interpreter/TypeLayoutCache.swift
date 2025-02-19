import IR
import FrontEnd
import Utils

/*
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
      let discriminatorBitsUsed
        = MemoryLayout.size(ofValue: basis.count) - basis.count.leadingZeroBitCount
      let discriminatorBitWidth = 0
      let discriminator = self[AnyType(BuiltinType.i(16))]
      let alignment = basis.lazy.map(\.bytes.alignment).max()!
      let payloadSize = basis.lazy.map(\.bytes.size).max()!
      let discriminatorOffset = 1
      fatalError()
    default:
      fatalError()
    }
    let a = AbstractTypeLayout(of: t, definedIn: p)
    fatalError()
  }
}
*/
