import pandas as pd

# Define the CSV content
data = {
    "Project": ["web4"] * 8,
    "Task ID": [1, 2, 3, 4, 5, 6, 7, 8],
    "Task Name": [
        "Requirements Gathering",
        "UI Wireframes",
        "Backend Setup",
        "API Design",
        "Database Modeling",
        "Smart Contract Prototypes",
        "Security Audit Plan",
        "Gantt Chart Review"
    ],
    "Assigned To": ["Alice", "Bob", "Charlie", "Dana", "Emma", "Frank", "Grace", "Team Lead"],
    "Start Date": [
        "2025-04-20",
        "2025-04-26",
        "2025-04-27",
        "2025-04-28",
        "2025-04-29",
        "2025-04-30",
        "2025-05-01",
        "2025-05-02"
    ],
    "End Date": [
        "2025-04-25",
        "2025-04-30",
        "2025-05-03",
        "2025-05-02",
        "2025-05-04",
        "2025-05-07",
        "2025-05-05",
        "2025-05-02"
    ],
    "Status": [
        "In Progress",
        "Pending",
        "Pending",
        "Pending",
        "Pending",
        "Not Started",
        "Not Started",
        "Not Started"
    ],
    "Priority": ["High", "Medium", "High", "High", "Medium", "High", "High", "Low"],
    "Notes": [
        "Meeting with stakeholders to define Web4 vision",
        "Sketch portal flows for Web4 dApp interface",
        "Init Node.js + IPFS integration",
        "Design GraphQL endpoints for Web4 data layer",
        "Evaluate decentralized storage vs. traditional DB",
        "Write initial Solidity/Ink! contracts",
        "Draft audit checklist for Web4 components",
        "Finalize timeline visualization"
    ]
}

# Create DataFrame
df = pd.DataFrame(data)

# Save to CSV
file_path = '/mnt/data/predev_work.csv'
df.to_csv(file_path, index=False)

# Display to user
import ace_tools as tools; tools.display_dataframe_to_user(name="predev_work.csv", dataframe=df)


