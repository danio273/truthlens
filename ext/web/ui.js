const TOOLTIP_ID = 'ai-manipulation-tooltip';
const STATUS_ID = 'ai-analysis-status-indicator';

function getOrCreateTooltip() {
  let tooltip = document.getElementById(TOOLTIP_ID);
  if (!tooltip) {
    tooltip = document.createElement('div');
    tooltip.id = TOOLTIP_ID;
    tooltip.style.cssText = `
      position: fixed;
      z-index: 2147483647;
      background: #181825;
      color: #cdd6f4;
      padding: 10px 14px;
      border-radius: 8px;
      font-size: 13px;
      max-width: 320px;
      box-shadow: 0 8px 24px rgba(0,0,0,0.5);
      display: none;
      pointer-events: none;
      font-family: system-ui, -apple-system, sans-serif;
      border: 1px solid #f38ba8;
      line-height: 1.4;
    `;
    document.documentElement.appendChild(tooltip);
  }
  return tooltip;
}

const StatusIndicator = {
  element: null,

  init() {
    if (document.getElementById(STATUS_ID)) return;

    this.element = document.createElement('div');
    this.element.id = STATUS_ID;
    this.element.style.cssText = `
      position: fixed;
      bottom: 20px;
      right: 20px;
      z-index: 2147483646;
      background: #11111b;
      color: #d6a1e3;
      padding: 10px 16px;
      border-radius: 30px;
      font-size: 13px;
      font-family: system-ui, sans-serif;
      border: 1px solid #d6a1e3;
      box-shadow: 0 4px 16px rgba(0,0,0,0.4);
      display: flex;
      align-items: center;
      gap: 10px;
      pointer-events: none;
      opacity: 0;
      transition: opacity 0.3s ease-in-out;
    `;

    this.element.innerHTML = `
      <div style="
        width: 14px; 
        height: 14px; 
        border: 2px solid #d6a1e3; 
        border-top-color: transparent; 
        border-radius: 50%; 
        animation: ai-spin 0.8s linear infinite;
      "></div>
      <span id="${STATUS_ID}-text">Аналіз тексту ШІ...</span>
    `;

    if (!document.getElementById('ai-spinner-styles')) {
      const style = document.createElement('style');
      style.id = 'ai-spinner-styles';
      style.textContent = `@keyframes ai-spin { to { transform: rotate(360deg); } }`;
      document.head.appendChild(style);
    }

    document.documentElement.appendChild(this.element);
  },

  show(queueLength) {
    if (!this.element) this.init();
    const textNode = document.getElementById(`${STATUS_ID}-text`);
    if (textNode) {
      textNode.textContent = `Trwa analiza (zostało: ${queueLength})...`;
    }
    this.element.style.opacity = '1';
  },

  hide() {
    if (this.element) {
      this.element.style.opacity = '0';
    }
  }
};

document.addEventListener('mouseover', (e) => {
  const target = e.target.closest('.ai-highlight-warn');
  if (!target) return;

  const reason = target.getAttribute('data-ai-reason');
  if (!reason) return;

  const tooltip = getOrCreateTooltip();
  tooltip.textContent = reason;
  tooltip.style.display = 'block';

  const rect = target.getBoundingClientRect();
  const tooltipRect = tooltip.getBoundingClientRect();

  let top = rect.top - tooltipRect.height - 8;
  let left = rect.left + (rect.width / 2) - (tooltipRect.width / 2);

  if (top < 10) top = rect.bottom + 8;
  if (left < 10) left = 10;
  if (left + tooltipRect.width > window.innerWidth - 10) {
    left = window.innerWidth - tooltipRect.width - 10;
  }

  tooltip.style.left = `${left}px`;
  tooltip.style.top = `${top}px`;
});

document.addEventListener('mouseout', (e) => {
  if (e.target.closest('.ai-highlight-warn')) {
    const tooltip = document.getElementById(TOOLTIP_ID);
    if (tooltip) tooltip.style.display = 'none';
  }
});