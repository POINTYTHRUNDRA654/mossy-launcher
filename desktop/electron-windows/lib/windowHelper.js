// Simple native helper using active-win to get focused window.
// For full window lists, consider node-window-manager or platform-specific APIs.
const activeWin = require('active-win');

async function getActiveWindowInfo() {
  try {
    const info = await activeWin();
    // info contains owner.name, title, id, bounds, memory, etc.
    return info;
  } catch (err) {
    return { error: err.message };
  }
}

module.exports = { getActiveWindowInfo };
