# Mossy Launcher — Desktop (Windows) — Prototype Scaffold

This folder contains an Electron-based Windows scaffold for Mossy Launcher.

## AI Programs Detection Script

**NEW:** Want to see which AI programs on your computer can work with Mossy Launcher?

This script will scan your system and display all detected AI programs including:
- AI Assistants (ChatGPT, Claude, Perplexity)
- AI-Powered Code Editors (Cursor, VS Code, JetBrains)
- Browsers with AI features (Edge with Copilot, Chrome, Brave)
- AI Art tools (Stable Diffusion, ComfyUI)
- Writing assistants (Grammarly, Notion AI)
- Development tools (Python, Anaconda, Jupyter)
- And more!

**To run the script (choose one method):**

**Method 1 - Easy (Recommended):**
1. Double-click `detect-ai-programs.bat`

**Method 2 - PowerShell:**
1. Open PowerShell in this directory
2. Run: `.\detect-ai-programs.ps1`
3. If you get an execution policy error, run: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass` first

## For End Users

### Option 1: Download Pre-built Executable (Recommended)
1. Go to the [Releases page](https://github.com/POINTYTHRUNDRA654/mossy-launcher/releases)
2. Look for `.exe` files (both installer and portable versions will be available)
3. Download and run the file
   - Installer version: Follow the installation prompts
   - Portable version: Runs directly without installation

**Note:** If you see "cannot open on this PC" error:
- Make sure you downloaded a `.exe` file from Releases, not the source code ZIP
- Check that you're running 64-bit Windows (this app requires x64)
- Windows Defender may block unsigned executables - click "More info" then "Run anyway"

### Option 2: Build from Source
If no pre-built releases are available:
1. Install [Node.js 18+](https://nodejs.org/)
2. Open Command Prompt or PowerShell
3. Navigate to the repository folder:
   ```cmd
   cd desktop/electron-windows
   ```
4. Install dependencies:
   ```cmd
   npm install
   ```
5. Build the application:
   ```cmd
   npm run build
   ```
6. The built files will be in `dist/` folder

## For Developers

Quick start:
1. `cd desktop/electron-windows`
2. `npm install`
3. `npm run start` (runs in development mode)

To build:
```cmd
npm run build
```

## Important Information

- This is a prototype scaffold. No data will be uploaded without explicit user consent.
- Tokens are stored using OS secure storage (keytar).
- For production quality voice and ML, integrate vendor SDKs or local GPU worker processes.

## Auto-update & Packaging

- electron-builder is configured to publish to GitHub Releases by default. Set a GH_TOKEN in repository secrets to allow publish in CI.
- Builds both NSIS installer and portable executable

## Privacy

- Program observation and screen capture require user consent. The app shows a consent dialog on first-run.
