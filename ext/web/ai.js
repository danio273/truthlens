const AIEngine = {
  async getFreshSession() {
    const aiApi = typeof LanguageModel !== 'undefined' ? LanguageModel : (window.ai?.languageModel || null);
    if (!aiApi) return null;
    return await aiApi.create();
  },

  async analyze(text) {
    const session = await this.getFreshSession();
    if (!session) return [];

    const prompt = `Jesteś bezlitosnym, logicznym filtrem analizującym tekst z mediów społecznościowych. Szukasz WYŁĄCZNIE poważnych manipulacji (gaslighting, szantaż emocjonalny, mowa nienawiści, toksyczna presja).

ZASADY ABSOLUTNE:
1. IGNORUJ interfejs i wezwania do akcji (np. "Show more", "Zapisz się", "Dołącz", "Kliknij", "Więcej").
2. IGNORUJ liczby, statystyki, pozdrowienia, opisy pogody i relacje z wydarzeń.
3. IGNORUJ zwykłe opinie polityczne, o ile nie stosują chwytów psychologicznych.
4. Celuj tylko w pełne, znaczące zdania.

Jeśli tekst jest czysty lub zawiera tylko normalny przekaz, odpowiedz dokładnie jednym słowem: CZYSTE.

Jeśli znajdziesz manipulację, MUSISZ użyć DOKŁADNIE poniższego formatu tagów (bez bloków kodu, bez JSON):
<MATCH>
<TEXT>dokładny cytat z tekstu</TEXT>
<REASON>Krótkie wyjaśnienie, dlaczego to manipulacja (po polsku)</REASON>
</MATCH>

Możesz użyć wielu bloków <MATCH>, jeśli jest więcej manipulacji.

Tekst do analizy:
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