function highlightTextSafe(rootNode, targetText, reasonText) {
  if (!targetText || targetText.trim().length < 5) return;

  const walker = document.createTreeWalker(rootNode, NodeFilter.SHOW_TEXT, null, false);
  const nodes = [];
  let node;

  while (node = walker.nextNode()) {
    if (node.parentNode && node.parentNode.classList.contains('ai-highlight-warn')) continue;
    
    const idx = node.nodeValue.toLowerCase().indexOf(targetText.toLowerCase());
    if (idx !== -1) {
      nodes.push({ node, idx });
    }
  }

  nodes.forEach(({ node, idx }) => {
    const textVal = node.nodeValue;
    const parent = node.parentNode;
    if (!parent) return;

    const span = document.createElement('span');
    span.className = 'ai-highlight-warn';
    span.setAttribute('data-ai-reason', reasonText);
    span.textContent = textVal.substring(idx, idx + targetText.length);

    const before = document.createTextNode(textVal.substring(0, idx));
    const after = document.createTextNode(textVal.substring(idx + targetText.length));

    parent.insertBefore(before, node);
    parent.insertBefore(span, node);
    parent.insertBefore(after, node);
    parent.removeChild(node);
  });
}