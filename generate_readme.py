from ai_tools.llm import ask

def read_repo_summary(path="."):
    content = ""
    for root, dirs, files in os.walk(path):
        for f in files:
            if f.endswith((".go", ".py")) and "test" not in f:
                with open(os.path.join(root, f)) as file:
                    content += f"\n### {f} ###\n" + file.read()[:300]
    return content

def generate_readme():
    code_summary = read_repo_summary("..")
    prompt = f"""
You're a blockchain-savvy dev. Here's a project codebase snippet:

{code_summary}

Generate a professional, clear `README.md` with:
- Project overview
- Key features
- Technologies
- How to run
- Folder structure
"""
    return ask(prompt)

if __name__ == "__main__":
    readme = generate_readme()
    with open("../README.generated.md", "w") as f:
        f.write(readme)
    print("✅ README.generated.md created")
