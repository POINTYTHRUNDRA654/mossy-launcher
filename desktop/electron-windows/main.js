const { app, BrowserWindow, ipcMain, dialog } = require('electron');
const path = require('path');
const keytar = require('keytar');
const { getActiveWindowInfo } = require('./lib/windowHelper');
const { uploadJsonl } = require('./lib/cloudSync');

function createMainWindow() {
  const win = new BrowserWindow({
    width: 1000,
    height: 700,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      sandbox: false
    }
  });

  win.removeMenu();
  win.loadFile(path.join(__dirname, 'renderer', 'index.html'));
}

app.whenReady().then(() => {
  createMainWindow();

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createMainWindow();
  });
});

// Graceful shutdown
app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

// IPC handlers for native tasks
const SERVICE_NAME = 'mossy-launcher';
const ACCOUNT_NAME = 'api-token';

// Token storage using keytar
ipcMain.handle('get-token', async () => {
  try {
    return await keytar.getPassword(SERVICE_NAME, ACCOUNT_NAME);
  } catch (err) {
    console.error('Error getting token:', err);
    return null;
  }
});

ipcMain.handle('set-token', async (_, token) => {
  try {
    await keytar.setPassword(SERVICE_NAME, ACCOUNT_NAME, token);
    return true;
  } catch (err) {
    console.error('Error setting token:', err);
    return false;
  }
});

// Get active window info
ipcMain.handle('get-active-window', async () => {
  return await getActiveWindowInfo();
});

// Screen capture (stub - could use desktopCapturer)
ipcMain.handle('capture-screen', async () => {
  return { message: 'Screen capture not yet implemented' };
});

// TTS speak (stub - could use say.js or Windows SAPI)
ipcMain.handle('tts-speak', async (_, text) => {
  console.log('TTS request:', text);
  // Could integrate with say.js here
  return { success: true, message: 'TTS not yet fully implemented' };
});

// Export logs
ipcMain.handle('export-logs', async (_, opts) => {
  try {
    // In a real implementation, you would have logs to export
    // For now, return a stub response
    return { ok: true, message: 'Export functionality stub' };
  } catch (err) {
    return { ok: false, error: err.message };
  }
});

// Privacy/consent dialog
ipcMain.handle('show-consent', async (_, message) => {
  const res = await dialog.showMessageBox({
    type: 'info',
    buttons: ['Accept', 'Decline'],
    defaultId: 0,
    cancelId: 1,
    title: 'Consent for program observation',
    message: 'Mossy Launcher needs permission to observe active programs and screen content. You must consent to continue.',
    detail: message || ''
  });
  return res.response === 0;
});
