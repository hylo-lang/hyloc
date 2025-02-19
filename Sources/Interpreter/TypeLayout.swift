import FrontEnd


/// The layout of a type in memory, including the positions of its components.
struct TypeLayout {

  /// Memory layout of a type, without any detail about components.
  struct Bytes {
    /// The minimum alignment of an instance.  Always a power of 2.
    let alignment: Int

    /// The number of bytes occupied by an instance.
    let size: Int

    /// The number of bytes between the beginnings of consecutive array elements.
    let stride: Int
  }

  /// Component types with their names (if any), and byte offsets from the base of this type's
  /// layout.
  typealias Component = (name: String?, type: AnyType, offset: Int)

  /// Aggregate layout values of this layout.
  let bytes: Bytes

  /// The minimum alignment of an instance.  Always a power of 2.
  var alignment: Int { bytes.alignment }

  /// The number of bytes occupied by an instance.
  var size: Int { bytes.size }

  /// The number of bytes between the beginnings of consecutive array elements.
  var stride: Int { bytes.stride }

  /// The sub-structure of `self`.
  ///
  /// For product types, info for each stored property.
  /// For union types, info for each case when it is active, followed by info for the discriminator.
  /// Empty otherwise (built-in types).
  let components: [Component]

  /// True iff `self` is the layout of a union type, which changes how
  /// its `components` are interpreted.
  let isUnionLayout: Bool
}

extension TypeLayout.Bytes {

  /// Replaces `self` with the layout of the tuple `(S, T)`, where `S` and `T` are types whose
  /// layout is represented by `self` and `t` respectively, returning the offset of the `T` instance
  /// in the tuple.
  mutating func append(_ t: Self) -> Int {
    self.alignment = max(self.alignment, t.alignment)
    let r = (self.size + (t.alignment - 1)).round(upToNearestMultipleOf: ) / t.alignment * t.alignment
  }
}
