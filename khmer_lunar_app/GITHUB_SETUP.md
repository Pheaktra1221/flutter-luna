# How to Build macOS DMG via GitHub Actions

## One-time setup (5 minutes)

### Step 1 — Create a GitHub account
Go to https://github.com and sign up (free).

### Step 2 — Create a new repository
1. Click **+** → **New repository**
2. Name it: `khmer-lunar-calendar`
3. Set to **Public** (required for free Actions minutes)
4. Click **Create repository**
5. **Do NOT** tick "Add README" or any other files

### Step 3 — Install Git on Windows
Download from: https://git-scm.com/download/win  
During install, choose "Git from the command line and also from 3rd-party software"

### Step 4 — Push the project to GitHub
Open PowerShell in the `khmer_lunar_app` folder and run:

```powershell
git init
git add .
git commit -m "Initial commit - Khmer Lunar Calendar"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/khmer-lunar-calendar.git
git push -u origin main
```
Replace `YOUR_USERNAME` with your actual GitHub username.

---

## After pushing — Watch the build

1. Go to your repository on GitHub
2. Click the **Actions** tab
3. You'll see **"Build macOS DMG"** running (takes ~10 minutes)
4. When it shows a green ✓, click on it

---

## Download the DMG

**Option A — From Actions artifacts:**
1. Click the completed workflow run
2. Scroll down to **Artifacts**
3. Click **KhmerLunarCalendar-macOS** to download the zip
4. Unzip → get `KhmerLunarCalendar-1.0.0.dmg`

**Option B — From Releases:**
1. Go to repository → **Releases** (right sidebar)
2. Click the latest release
3. Download `KhmerLunarCalendar-1.0.0.dmg` directly

---

## Re-build after code changes

Every time you push new code, it rebuilds automatically:
```powershell
git add .
git commit -m "Update app"
git push
```

## Manual trigger (without pushing code)
1. Go to **Actions** tab on GitHub
2. Click **"Build macOS DMG"**
3. Click **"Run workflow"** → **"Run workflow"**
