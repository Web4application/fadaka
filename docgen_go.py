import os
from ai_tools.llm import ask

def generate_go_docs(file_path):
    with open(file_path) as f:
        code = f.read()
    prompt = f"""
You're a Go blockchain engineer. Summarize each function in this Go file:

{code}

Write output in Markdown.
"""
    return ask(prompt)

if __name__ == "__main__":
    for root, _, files in os.walk("../"):
        for file in files:
            if file.endswith(".go"):
                out = generate_go_docs(os.path.join(root, file))
                out_file = os.path.join(root, file.replace(".go", ".doc.md"))
                with open(out_file, "w") as f:
                    f.write(out)
