struct Heap<TypeSystem: TypeSystemProtocol> {

  typealias Allocations = [Allocation]
  typealias RawMemory = [UInt8]

  struct InitializedRegion {
    let baseOffset: RawMemory.Index
    let type: TypeSystem.TypeID
    var count: Int
  }

  struct Allocation {
    typealias ID = Allocations.Index

    var memory: RawMemory
    var initializedRegions: [InitializedRegion]
  }

  struct Address {
    let allocation: Allocation.ID
    let offset: RawMemory.Index
  }

  var allocation: [Allocation] = []
  let typeSystem: TypeSystem

  init(typeSystem: TypeSystem) { self.typeSystem = typeSystem }

}
