const Scanner = {
  queue: [],
  isWorking: false,
  processedCache: new Map(), 

  getFingerprint(text) {
    if (!text) return '';
    return text
      .toLowerCase()
      .replace(/[0-9]/g, '')
      .replace(/[^\p{L}]/gu, '')
      .trim();
  },

  start() {
    this.scanDOM();

    let timeout;
    const observer = new MutationObserver((mutations) => {
      
      for (const mutation of mutations) {
        for (const node of mutation.addedNodes) {
      
          if (node.nodeType !== Node.ELEMENT_NODE) continue;

          const posts = node.matches?.('article, [data-testid="tweet"]') 
            ? [node] 
            : (node.querySelectorAll?.('article, [data-testid="tweet"]') || []);

          posts.forEach(post => {
            const status = post.getAttribute('data-ai-scanned');
            if (status === 'done' || status === 'processing' || status === 'queued') return;

            const text = post.innerText?.trim();
            if (!text || text.length < 40) return;

            const fingerprint = this.getFingerprint(text);

            if (this.processedCache.has(fingerprint)) {
              const findings = this.processedCache.get(fingerprint);
              if (findings && findings.length > 0) {
                findings.forEach(f => highlightTextSafe(post, f.text, f.reason));
              }
              post.setAttribute('data-ai-scanned', 'done');
            }
          });
        }
      }

      clearTimeout(timeout);
      timeout = setTimeout(() => this.scanDOM(), 500); 
    });

    observer.observe(document.body, { childList: true, subtree: true });
  },

  scanDOM() {
    const selectors = 'article, [data-testid="tweet"]';
    const posts = document.querySelectorAll(selectors);
    
    posts.forEach(post => {
      const status = post.getAttribute('data-ai-scanned');
      if (status === 'queued' || status === 'processing' || status === 'done') return;
      
      const text = post.innerText?.trim();
      if (!text || text.length < 40) {
        post.setAttribute('data-ai-scanned', 'skipped');
        return;
      }

      const fingerprint = this.getFingerprint(text);

      if (this.processedCache.has(fingerprint)) {
        if (status !== 'done') {
          const findings = this.processedCache.get(fingerprint);
          if (findings && findings.length > 0) {
            findings.forEach(f => highlightTextSafe(post, f.text, f.reason));
          }
          post.setAttribute('data-ai-scanned', 'done');
        }
        return; 
      }

      post.setAttribute('data-ai-scanned', 'queued');
      this.queue.push({ element: post, text: text, fingerprint: fingerprint });
    });

    this.processQueue();
  },

  async processQueue() {
    if (this.isWorking || this.queue.length === 0) return;
    this.isWorking = true;

    while (this.queue.length > 0) {
      StatusIndicator.show(this.queue.length);

      const item = this.queue.shift();
      const post = item.element;
      const text = item.text;
      const fingerprint = item.fingerprint;

      if (!document.body.contains(post)) continue;

      post.setAttribute('data-ai-scanned', 'processing');
      const findings = await AIEngine.analyze(text);
      
      this.processedCache.set(fingerprint, findings);

      if (document.body.contains(post)) {
        findings.forEach(f => {
          highlightTextSafe(post, f.text, f.reason);
        });
        post.setAttribute('data-ai-scanned', 'done');
      }
    }

    this.isWorking = false;
    StatusIndicator.hide();
  }
};