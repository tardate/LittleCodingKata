/***
 * Excerpted from "Eloquent Ruby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit https://pragprog.com/titles/eruby2 for more book information.
***/
// See: TBD
@JRubyClass(name="Object", include="Kernel")
public class RubyObject extends RubyBasicObject {
    // Five hundred lines of very serious Java omitted...
}


// See: TBD
public class RubyArray<T extends IRubyObject> 
    extends RubyObject implements List, RandomAccess {
 
    // Tons of code omitted....

    /** rb_ary_empty_p
     *
     */
    @JRubyMethod(name = "empty?")
    public IRubyObject empty_p(ThreadContext context) {
        return realLength == 0 ? context.tru : context.fals;
    }

    // Tons more code omitted...
}

// See: TBD core/src/main/java/org/jruby/RubyArray.java
/** rb_ary_each_index
 *
 */
public IRubyObject eachIndex(ThreadContext context, Block block) {
    if (!block.isGiven()) throw context.runtime.newLocalJumpErrorNoBlock();

    for (int i = 0; i < realLength; i++) {
        block.yield(context, asFixnum(context, i));
    }
    return this;
}

// See: TBD
@CoreMethod(names = "empty?")
public abstract static class EmptyNode extends CoreMethodArrayArgumentsNode {

    @Specialization
    boolean isEmpty(RubyArray array) {
        return array.size == 0;
    }
}
