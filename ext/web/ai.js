const AIEngine = {
  async getFreshSession() {
    const aiApi = typeof LanguageModel !== 'undefined' ? LanguageModel : (window.ai?.languageModel || null);
    if (!aiApi) return null;
    return await aiApi.create();
  },

  async analyze(text) {
    const session = await this.getFreshSession();
    if (!session) return [];

    const prompt = `${MANIPULATION_PROMPT} 
    "${text}"`;

    try {
      const response = await session.prompt(prompt);
      if (session.destroy) session.destroy(); 
      return this.parseTags(response);
    } catch (e) {
      console.warn("[AI] Generation error:", e);
      if (session.destroy) session.destroy();
      return [];
    }
  },

  parseTags(rawText) {
    const results = [];
    const regex = /<MATCH>[\s\S]*?<TEXT>\s*([\s\S]*?)\s*<\/TEXT>[\s\S]*?<REASON>\s*([\s\S]*?)\s*<\/REASON>[\s\S]*?<\/MATCH>/gi;
    
    let match;
    while ((match = regex.exec(rawText)) !== null) {
      const foundText = match[1].trim();
      const foundReason = match[2].trim();
      
      if (foundText.split(/\s+/).length > 2) {
        results.push({ text: foundText, reason: foundReason });
      }
    }
    return results;
  }
};