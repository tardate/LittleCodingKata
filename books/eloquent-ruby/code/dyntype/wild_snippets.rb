#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
=begin
# See: TBD
class Formula
  # Rest of the class omitted...

  def initialize(name, path, spec, alias_path: nil, 
    tap: nil, force_bottle: false)
    # ...
  end
end


# See: TBD
class Formula
  # Indirectly pulls in T::Sig.
  extend T::Helpers

  # Rest of the class omitted...

  sig {
        params(
          name: String,
          path: Pathname,
          spec: Symbol, 
          alias_path: T.nilable(Pathname),
          tap: T.nilable(Tap),
          force_bottle: T::Boolean).void
  }
  def initialize(name, path, spec, alias_path: nil, 
    tap: nil, force_bottle: false)
    # ...
  end
end
=end
