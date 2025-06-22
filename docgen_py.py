import ast, os
from ai_tools.llm import ask

def extract_py_functions(path):
    with open(path) as f:
        tree = ast.parse(f.read())
    return [node.name for node in ast.walk(tree) if isinstance(node, ast.FunctionDef)]

def generate_docs(file_path):
    with open(file_path) as f:
        code = f.read()
    prompt = f"""
Summarize each function in this Python file:

{code}

Output in Markdown, one section per function.
"""
    return ask(prompt)

if __name__ == "__main__":
    for root, _, files in os.walk("../"):
        for file in files:
            if file.endswith(".py") and "test" not in file:
                doc = generate_docs(os.path.join(root, file))
                out_file = os.path.join(root, file.replace(".py", ".doc.md"))
                with open(out_file, "w") as f:
                    f.write(doc)
