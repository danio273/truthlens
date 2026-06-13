(async function init() {
  getOrCreateTooltip();
  StatusIndicator.init();
  
  const ready = await AIEngine.getFreshSession();
  if (ready) {
    Scanner.start();
  } else {
    console.warn("[AI] Failed to launch the built-in Gemini.");
  }
})();