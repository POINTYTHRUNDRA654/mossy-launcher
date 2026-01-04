const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('api', {
  // Key/value token store action (main will call keytar)
  getToken: () => ipcRenderer.invoke('get-token'),
  setToken: (token) => ipcRenderer.invoke('set-token', token),

  // Native window info
  getActiveWindow: () => ipcRenderer.invoke('get-active-window'),

  // Simple screen capture trigger (renderer can call desktopCapturer if enabled)
  captureScreen: () => ipcRenderer.invoke('capture-screen'),

  // Voice/TTS control (renderer-first, stubbed)
  ttsSpeak: (text) => ipcRenderer.invoke('tts-speak', text),

  // Export logs / RL JSONL
  exportLogs: (opts) => ipcRenderer.invoke('export-logs', opts),

  // Show consent dialog
  requestConsent: (message) => ipcRenderer.invoke('show-consent', message)
});
