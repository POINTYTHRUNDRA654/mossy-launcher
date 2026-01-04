# How to Run Mossy Launcher

## ⚠️ Important: Downloaded Source Code?

If you downloaded this as a ZIP file from GitHub, **you cannot run it directly**. This is source code, not a compiled application.

## 🎯 To Get a Working Application:

### Option 1: Download Pre-built Release (Easiest)
1. Go to: https://github.com/POINTYTHRUNDRA654/mossy-launcher/releases
2. Download a `.exe` file (NOT the "Source code" ZIP)
3. Run the downloaded `.exe` file

**Files to look for:**
- `Mossy Launcher-X.X.X-x64.exe` - Installer version
- `Mossy Launcher-X.X.X-x64-portable.exe` - Portable version (no install needed)

### Option 2: Build It Yourself
If there are no releases yet, you need to build from source:

**Requirements:**
- [Node.js 18 or newer](https://nodejs.org/)
- Windows 10/11 (64-bit)

**Steps:**
1. Open Command Prompt or PowerShell
2. Navigate to this folder:
   ```
   cd desktop/electron-windows
   ```
3. Install dependencies:
   ```
   npm install
   ```
4. Build the application:
   ```
   npm run build
   ```
5. Find your executable in `desktop/electron-windows/dist/`

## ❓ Common Issues

**"Cannot open on this PC" Error?**
- You likely downloaded the source code ZIP instead of a built `.exe` file
- Solution: Follow Option 1 or Option 2 above

**No releases available?**
- The application hasn't been built yet by GitHub Actions
- Solution: Use Option 2 to build it yourself

**Need help?**
- See `desktop/electron-windows/README.md` for more details
- Open an issue on GitHub
