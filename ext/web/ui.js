const TOOLTIP_ID = 'ai-manipulation-tooltip';
const STATUS_ID = 'ai-analysis-status-indicator';

function getOrCreateTooltip() {
  let tooltip = document.getElementById(TOOLTIP_ID);
  if (!tooltip) {
    tooltip = document.createElement('div');
    tooltip.id = TOOLTIP_ID;
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

    this.element.innerHTML = `
      <div class="ai-spinner"></div>
      <span id="${STATUS_ID}-text">Trwa analiza...</span>
    `;

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