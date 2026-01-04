const logEl = document.getElementById('log');
const tokenInput = document.getElementById('token');
const apiUrlInput = document.getElementById('api-url');

function log(...args) {
  logEl.textContent += args.join(' ') + '\n';
  logEl.scrollTop = logEl.scrollHeight;
}

document.getElementById('save-token').addEventListener('click', async () => {
  const token = tokenInput.value.trim();
  if (!token) return log('No token provided');
  await window.api.setToken(token);
  log('Token saved securely.');
});

document.getElementById('load-token').addEventListener('click', async () => {
  const t = await window.api.getToken();
  tokenInput.value = t || '';
  log('Loaded token:', !!t);
});

document.getElementById('consent').addEventListener('click', async () => {
  const ok = await window.api.requestConsent('Mossy Launcher will capture active window titles and small screenshots for assistance. Do you consent?');
  log('Consent result:', ok);
});

document.getElementById('get-active').addEventListener('click', async () => {
  try {
    const win = await window.api.getActiveWindow();
    log('Active window:', JSON.stringify(win || {}));
  } catch (err) { log('Error getting active window:', err.message); }
});

document.getElementById('start-voice').addEventListener('click', async () => {
  if (!('webkitSpeechRecognition' in window) && !('SpeechRecognition' in window)) {
    log('Web Speech API not available in this environment. Use native/SDK fallback.');
    return;
  }

  const SpeechRecognition = window.SpeechRecognition || window.webkitSpeechRecognition;
  const recognizer = new SpeechRecognition();
  recognizer.continuous = true;
  recognizer.interimResults = false;
  recognizer.lang = 'en-US';

  recognizer.onresult = (event) => {
    const transcript = Array.from(event.results).map(r => r[0].transcript).join('\n');
    log('Transcribed:', transcript);
  };
  recognizer.onerror = (e) => log('Voice error:', e.error);
  recognizer.start();
  log('Started browser speech recognition (prototype).');
});

document.getElementById('speak').addEventListener('click', async () => {
  const text = 'Hello — this is a prototype test from Mossy Launcher.';
  if ('speechSynthesis' in window) {
    const u = new SpeechSynthesisUtterance(text);
    speechSynthesis.speak(u);
    log('Spoken via browser TTS.');
  } else {
    await window.api.ttsSpeak(text);
    log('Requested native TTS (fallback).');
  }
});

document.getElementById('export').addEventListener('click', async () => {
  const apiBase = apiUrlInput.value.trim();
  const token = tokenInput.value.trim();
  const res = await window.api.exportLogs({ apiBase, token });
  log('Export result:', res && res.ok ? 'uploaded' : JSON.stringify(res));
});
