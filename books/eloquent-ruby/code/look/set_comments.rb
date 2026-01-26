#---
# Excerpted from "Eloquent Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit https://pragprog.com/titles/eruby2 for more book information.
#---
require_relative "../common/document"

# The copyright below applies to the documentation strings that follow.

# set.rb - defines the Set class
#
# Copyright (c) 2002-2024 Akinori MUSHA <knu@iDaemons.org>
#
# Documentation by Akinori MUSHA and Gavin Sinclair.

# This library provides the Set class, which implements a collection
# of unordered values with no duplicates. It is a hybrid of Array's
# intuitive inter-operation facilities and Hash's fast lookup.

# require 'set'
# s1 = Set[1, 2]                        #=> #<Set: {1, 2}>
# s2 = [1, 2].to_set                    #=> #<Set: {1, 2}>
# s1 == s2                              #=> true
# s1.add("foo")                         #=> #<Set: {1, 2, "foo"}>
# s1.merge([2, 6])                      #=> #<Set: {1, 2, "foo", 6}>
# s1.subset?(s2)                        #=> false
# s2.subset?(s1)                        #=> true
