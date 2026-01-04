# Mossy Launcher — Desktop (Windows) — Prototype Scaffold

This folder contains an Electron-based Windows scaffold for Mossy Launcher.

## For End Users

### Option 1: Download Pre-built Executable (Recommended)
1. Go to the [Releases page](https://github.com/POINTYTHRUNDRA654/mossy-launcher/releases)
2. Download either:
   - `Mossy Launcher-<version>-x64.exe` (Installer - recommended)
   - `Mossy Launcher-<version>-x64-portable.exe` (No installation required)
3. Run the downloaded file

**Note:** If you see "cannot open on this PC" error:
- Make sure you downloaded the `.exe` file from Releases, not the source code ZIP
- Check that you're running 64-bit Windows (this app requires x64)
- Try the portable version if the installer doesn't work

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
