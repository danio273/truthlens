const isSystemPage = (url) =>
  url.startsWith("chrome://") ||
  url.startsWith("edge://") ||
  url.startsWith("about:") ||
  url.startsWith("vivaldi://");

window.chromeExtensionInterop = {
  getSelectedText: async () => {
    const [tab] = await chrome.tabs.query({ active: true, currentWindow: true });
    const url = tab.url || "";

    if (isSystemPage(url)) return "";

    const results = await chrome.scripting.executeScript({
      target: { tabId: tab.id },
      func: () => window.getSelection()?.toString() || ""
    });
    
    return results[0]?.result || "";
  }
};