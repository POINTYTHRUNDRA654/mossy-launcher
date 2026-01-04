# Mossy Launcher — Desktop (Windows) — Prototype Scaffold

This folder contains an Electron-based Windows scaffold for Mossy Launcher.

Quick start (developer):
1. cd desktop/electron-windows
2. npm install
3. npm run start

Important:
- This is a prototype scaffold. No data will be uploaded without explicit user consent.
- Tokens are stored using OS secure storage (keytar).
- For production quality voice and ML, integrate vendor SDKs or local GPU worker processes as described in ml/README.md (not included in this initial PR).

Auto-update & packaging:
- electron-builder is configured to publish to GitHub Releases by default. Set a GH token in repository secrets to allow publish in CI.

Privacy:
- Program observation and screen capture require user consent. The app shows a consent dialog on first-run.
