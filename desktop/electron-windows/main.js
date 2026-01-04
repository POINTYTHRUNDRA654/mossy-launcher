const { app, BrowserWindow, ipcMain, dialog } = require('electron');
const path = require('path');

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

// NOTE: IPC handlers for long-running native tasks will be registered in preload/main bridge.
// Example placeholder: show a privacy/consent dialog (first-run)
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
