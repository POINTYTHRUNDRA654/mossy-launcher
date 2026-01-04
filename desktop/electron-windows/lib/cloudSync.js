// Lightweight sync/upload helper for RL logs and telemetry (opt-in)
const fetch = require('node-fetch');
const fs = require('fs');
const path = require('path');

async function uploadJsonl(apiBase, token, filePath) {
  if (!apiBase || !token) throw new Error('Missing apiBase or token');
  const url = `${apiBase.replace(/\/$/,'')}/v1/desktop/import-rl`;
  const stream = fs.createReadStream(filePath);
  const res = await fetch(url, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${token}`,
      'Content-Type': 'application/jsonl'
    },
    body: stream
  });
  return { ok: res.ok, status: res.status, text: await res.text() };
}

module.exports = { uploadJsonl };
