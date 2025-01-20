# #036 Bash Function Inference

How to test for the presence of functions in order to branch to arbitrary functions by name.

## Notes

In shell scripts, it is often useful to branch to a specific function given a parameter that matches the function name in some way.

A naive approach is to encode all the options with a case statement. For example:

    function run_a() {}
    function run_b() {}
    name=$1
    case ${name} in
    a|b)
      run_${name}
    *}
    echo "no match"
    ;;
    esac

But that is a bit tedious, because each new function not only needs to be defined, but also added to the case statement.

## The Trick

The [type](https://ss64.com/bash/type.html) builtin command can be used to test for shell functions (among other things).
For example:

    if type  -t "${function_name}" 2>/dev/null | grep -q 'function'
    then
      echo "calling the function now we know it exists.."
      $function_name
    else
      echo "there is no function by that name"
    fi


## Test Code

The [test.sh](./test.sh) script demonstrates the technique in a bit more detail. Here's a console transcript of it in action:

![console_test](./assets/console_test.png?raw=true)

## Credits and References
* [type BASH builtin command](https://ss64.com/bash/type.html)
* [Using case statements](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_03.html) - Bash Guide for Beginners
* [Determine if a function exists in bash](https://stackoverflow.com/questions/85880/determine-if-a-function-exists-in-bash) - stackoverflow
* [Test for function's existence that can work on both bash and zsh?](https://unix.stackexchange.com/questions/332005/test-for-functions-existence-that-can-work-on-both-bash-and-zsh) - stackexchange
