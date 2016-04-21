# import not_how_to_do_it_hax.constants as constants
# ^ this works with nosetests but fails when running `python hello.py`

# import constants
# ^ this works when running `python hello.py` but fails with nosetests

def message():
    # return constants.HELLO  # so can't do this
    return "Hello"
