#! /usr/bin/env python
import logging
from functools import wraps

logging.basicConfig(level=logging.INFO)
log = logging.getLogger('demonstrator')


def method_wrapper(func):
    """ Defines a basic decorator for any arbitrary class method.
    Since it does not use functools.wraps, details of the wrapped method are obscured.
    """

    def wrapper(self, *args, **kwargs):
        before_details = "method_wrapper.before: {}.{} called with args: {} kwargs: {}".format(
            type(self).__name__,
            func.__name__,
            args,
            kwargs
        )
        log.info(before_details)

        result = func(self, *args, **kwargs)

        after_details = "method_wrapper.after: returns {}".format(result)
        log.info(after_details)
        return result

    return wrapper


def wrapped_method_wrapper(func):
    """ Defines a basic decorator for any arbitrary class method.
    This is identical to method_wrapper(), however it uses functools.wraps
    to ensure details of the wrapped method are not obfuscated.
    """

    @wraps(func)
    def wrapper(self, *args, **kwargs):
        before_details = "wrapped_method_wrapper.before: {}.{} called with args: {} kwargs: {}".format(
            type(self).__name__,
            func.__name__,
            args,
            kwargs
        )
        log.info(before_details)

        result = func(self, *args, **kwargs)

        after_details = "wrapped_method_wrapper.after: returns {}".format(result)
        log.info(after_details)
        return result

    return wrapper


class Demonstrator(object):
    """ Simple class for demonstrating the method decorators. """

    @method_wrapper
    def apples(self, payload, message, example_id):
        """ Doc for apples(). """
        log.info("running apples with payload: {}, message: '{}', example_id: {}".format(
            payload, message, example_id
        ))
        payload.append(message)
        payload.append(example_id)
        return payload

    @wrapped_method_wrapper
    def oranges(self, payload, message, example_id):
        """ Doc for oranges(). """
        log.info("running oranges with payload: {}, message: '{}', example_id: {}".format(
            payload, message, example_id
        ))
        payload.append(message)
        payload.append(example_id)
        return payload


if __name__ == '__main__':
    instance = Demonstrator()

    result = instance.apples([], 'a message to apples', example_id=33)
    print "apples() returned {}".format(result)

    result = instance.oranges([], 'a message to oranges', example_id=33)
    print "oranges() returned {}".format(result)
