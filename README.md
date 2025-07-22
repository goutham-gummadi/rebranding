Here’s a focused `README.md` section specifically for the **Rebranding** scripts in your repository:

---

## 🔄 Rebranding Scripts

This folder contains automation scripts designed to simplify and accelerate the process of **rebranding user accounts** across various systems. These scripts are particularly useful during company mergers, acquisitions, or organizational restructuring.

### ✨ Features

- **Bulk Account Renaming** – Automatically update usernames, display names, and email aliases to reflect new branding standards.
- **Profile Updates** – Modify user attributes such as job titles, departments, and office locations.
- **Email Domain Migration** – Assist in transitioning users to new email domains with minimal disruption.
- **Group Membership Adjustments** – Ensure users are correctly assigned to new or updated Active Directory groups.
- **Logging & Reporting** – Generate detailed logs and reports for auditing and rollback purposes.

### ⚙️ Usage

1. **Review the script configuration**:
   - Update CSV or JSON input files with user data.
   - Set domain and naming conventions in the script header.

2. **Run the script**:
   - Use PowerShell or your preferred shell environment.
   - Example:
     ```powershell
     .\Rebrand-Accounts.ps1 -InputFile ".\users.csv" -LogFile ".\rebrand-log.txt"
     ```

3. **Verify changes**:
   - Check logs and optionally run audit scripts to confirm successful updates.


Would you like this saved as a separate `README.md` file for the `rebranding` folder?
