import os
import openai

openai.api_key = os.getenv("OPENAI_API_KEY")

def ask(prompt, model="gpt-4", temp=0.3):
    response = openai.ChatCompletion.create(
        model=model,
        messages=[{"role": "user", "content": prompt}],
        temperature=temp
    )
    return response.choices[0].message.content.strip()
