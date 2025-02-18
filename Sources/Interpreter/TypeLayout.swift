import FrontEnd

/// The layout of a type in memory
struct TypeLayout {
  typealias Component = (name: String?, type: AnyType, offset: Int)

  /// The sub-structure of `self`.
  ///
  /// For product types, info for each stored property.
  /// For union types, info for each case when it is active, followed by info for the discriminator.
  /// Empty otherwise (built-in types).
  let components: [Component]

  /// The minimum alignment of an instance.  Always a power of 2.
  let alignment: Int

  /// The number of bytes occupied by an instance.
  let size: Int

  /// The number of bytes between the beginnings of consecutive array elements.
  let stride: Int

  /// True iff `self` is the layout of a union type, which changes how
  /// its `components` are interpreted.
  let isUnionLayout: Bool
}
