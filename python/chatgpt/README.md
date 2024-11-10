# #308 OpenAI with Python

The basics of using ChatGPT/OpenAI APIs with Python

## Notes

Ironically, I asked AI to write some OpenAI examples for python .. and it gave me outdated code that no longer works!

Here's a quick outline and example of using the [openai-python](https://github.com/openai/openai-python) library
to make basic Open API calls.

## Installation

This example uses the openai python client. Install with pip:

    pip install -r requirements.txt

To use the API, an API key is required from <https://platform.openai.com/settings/organization/api-keys>.
Set the defautl environement variable for the following examples to work:

    export OPENAI_API_KEY='your-key'

Once installed, the library actually provides a command line tool that can be used to make one-off queries, for example:

    $ openai api chat.completions.create -m gpt-4o-mini -g user "Hello, who are you?"
    Hello! I’m an AI language model created by OpenAI. I'm here to help answer your questions, provide information, and assist you with a variety of topics. How can I help you today?

## Python Usage

The [openai-python](https://github.com/openai/openai-python) library provides easy access to the OpenAI aPI.
Here's a basic example:

Create a client with optional configuration details. By default, will use API key from `OPENAI_API_KEY` environment variable

  client = OpenAI()

Call the [chat completion API](https://platform.openai.com/docs/api-reference/chat/create)
with a prompt, and selected [model](https://platform.openai.com/docs/models):

  response = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "Hello, who are you?",
        }
    ],
    model="gpt-4o-mini"
  )

Parse the response and do something with it.

  return response.choices[0].message.content.strip()

Note: response data will follow the JSON schema of the API being called. In this case a [chat completion object](https://platform.openai.com/docs/api-reference/chat/object).

## Example Run

The [chatgpt_query.py](./chatgpt_query.py) is a simple wrapper around the API calls:

    $ ./chatgpt_query.py "hello world"
    Hello! How can I assist you today?

## Credits and References

* [Models](https://platform.openai.com/docs/models)
* [Text generation](https://platform.openai.com/docs/guides/text-generation)
* [openai-python](https://github.com/openai/openai-python)
