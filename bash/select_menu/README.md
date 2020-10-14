# #003 Select Menus

Getting multiple-choice input from a user in a bash script.


## Notes

Bash scripts are great for automating system management tasks.
They are made more useful and general if there's a way for the user to change the behaviour.
This is what command line parameters are usually for.

But sometimes it is best to get interactive input with a menu of options.

The `select` built-in function provides a very simple way to implement a menu.

## Example

The [example.sh](./example.sh) demonstrates a basic menu using select.

```
$ ./example.sh

This script demonstrates the basic select menu.

1) apple
2) orange
3) quit
select> 1
You picked apple (1)
select> 2
You picked orange (2)
select> 3
You picked quit (3)

```

## Credits and References
* [9.6. Making menus with the select built-in](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_06.html)
* [How can I create a select menu in a shell script?](http://askubuntu.com/questions/1705/how-can-i-create-a-select-menu-in-a-shell-script)
* [Menu driven scripts](https://bash.cyberciti.biz/guide/Menu_driven_scripts)
