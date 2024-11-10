#! /usr/bin/env python
from openai import OpenAI
import sys
import os

def query_chatgpt(prompt, model):
  client = OpenAI()
  response = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": prompt,
        }
    ],
    model=model
  )
  return response.choices[0].message.content.strip()

if __name__ == "__main__":
  if len(sys.argv) < 2:
    print("Usage: python chatgpt_query.py <your query> (model)")
    sys.exit(1)

  query = sys.argv[1]
  model = sys.argv[2] if len(sys.argv) > 2 else "gpt-4o-mini"
  response = query_chatgpt(query, model)
  print(response)
