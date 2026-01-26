/***
 * Excerpted from "Eloquent Ruby",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit https://pragprog.com/titles/eruby2 for more book information.
***/
%if 0

// See: https://github.com/ruby/ruby/blob/a36ebb18a6d4c4726915b6d7c16cfdbf4e5d417b/array.c#L2788C1-L2792C2
static VALUE
rb_ary_empty_p(VALUE ary)
{
    return RBOOL(RARRAY_LEN(ary) == 0);
}


// See: TBD
void
Init_Array(void)
{
    // ...

    rb_cArray  = rb_define_class("Array", rb_cObject);
    rb_include_module(rb_cArray, rb_mEnumerable);
    
    // ...

    rb_define_method(rb_cArray, "==", rb_ary_equal, 1);
    rb_define_method(rb_cArray, "eql?", rb_ary_eql, 1);
    rb_define_method(rb_cArray, "hash", rb_ary_hash, 0);

    // ...

    rb_define_method(rb_cArray, "empty?", rb_ary_empty_p, 0);

    // ...
}

// See: TBD
void
Init_class_hierarchy(void)
{
    rb_cBasicObject = boot_defclass("BasicObject", 0);
    rb_cObject = boot_defclass("Object", rb_cBasicObject);

    // ...

    rb_cModule = boot_defclass("Module", rb_cObject);
    rb_cClass =  boot_defclass("Class",  rb_cModule);

    // ...
}
//

// See: TBD
static VALUE
rb_ary_each_index(VALUE ary)
{
    long i;
    RETURN_SIZED_ENUMERATOR(ary, 0, 0, ary_enum_length);

    for (i=0; i<RARRAY_LEN(ary); i++) {
        rb_yield(LONG2NUM(i));
    }
    return ary;
}

%endif
