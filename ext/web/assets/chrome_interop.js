window.chromeExtensionInterop = {
  getSelectedText: async () => {
    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
    
    const results = await chrome.scripting.executeScript({
      target: { tabId: tab.id },
      func: () => window.getSelection()?.toString() || ""
    });
    
    return results[0]?.result || "";
  }
};