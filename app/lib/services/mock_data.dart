import '../models/flashcard.dart';
import '../models/check.dart';

final falshcards = <Flashcard>[
  Flashcard(
      url: "https://twitter.com/Adbodnar/status/1919723460919509381",
      answer: [
        Check(
          title: "Wiarygodność źródła",
          shortDescription:
              "Informacje o pozbawieniu immunitetu są potwierdzone.",
          description:
              "Wiele niezależnych źródeł potwierdza, że Grzegorz Braun został pozbawiony immunitetu europarlamentarzysty 6 maja 2025 roku w związku z 7 przestępstwami.",
          status: CheckStatus.verified,
        ),
        Check(
          title: "Jakość logiki",
          shortDescription:
              "Brak widocznych błędów logicznych czy fałszywych wniosków.",
          description:
              "Tekst przedstawia fakty dotyczące pozbawienia immunitetu i dalszych kroków prawnych w sposób spójny i logiczny, bez manipulacji argumentacją.",
          status: CheckStatus.verified,
        ),
        Check(
          title: "Presja emocjonalna",
          shortDescription:
              "Tekst jest neutralny, bez nadmiernych emocjonalnych apelacji.",
          description:
              "Analizowany tekst opisuje wydarzenia w sposób rzeczowy, unikając języka nacechowanego emocjonalnie, dramatyzacji czy prób wywierania presji na czytelnika.",
          status: CheckStatus.verified,
        ),
        Check(
          title: "Struktura manipulacyjna",
          shortDescription:
              "Struktura tekstu jest informacyjna, nie manipulacyjna.",
          description:
              "Tekst jest przedstawiony w sposób klarowny i informacyjny, bez cech manipulacyjnej struktury, takich jak sensacyjne nagłówki czy jednostronne przedstawianie faktów.",
          status: CheckStatus.verified,
        ),
      ]),
  Flashcard(
    url: "https://twitter.com/SlawomirMentzen/status/1975246504345362593",
    answer: [
      Check(
        title: "Wiarygodność źródła",
        shortDescription:
            "Brak konkretnych źródeł dla przedstawionych twierdzeń.",
        description:
            "Tekst nie podaje żadnych konkretnych źródeł, nazwisk dziennikarzy ani tytułów artykułów, które potwierdzałyby roszczenia o planach Ukraińców czy ich oburzeniu. Dostępne źródła jedynie potwierdzają, że to oświadczenie zostało wygłoszone, a nie weryfikują jego treści.",
        status: CheckStatus.questionable,
      ),
      Check(
        title: "Jakość logiki",
        shortDescription: "Tekst zawiera uogólnienia i fałszywe wnioski.",
        description:
            "Tekst dokonuje nieuzasadnionych uogólnień, sugerując, że chęć reprezentacji politycznej oznacza zamiar 'rządzenia naszym krajem'. Wykorzystuje argumenty typu 'chochoł', przypisując grupie intencje, które nie są bezpośrednio poparte.",
        status: CheckStatus.falseInfo,
      ),
      Check(
        title: "Presja emocjonalna",
        shortDescription: "Wykorzystano emocjonalne słownictwo i straszenie.",
        description:
            "Tekst używa silnie nacechowanego emocjonalnie języka, takiego jak 'zdobyć reprezentację', 'oburzenie', 'obce interesy' oraz 'musimy bronić', aby wywołać strach i poczucie zagrożenia, zamiast opierać się na faktach.",
        status: CheckStatus.falseInfo,
      ),
      Check(
        title: "Struktura manipulacyjna",
        shortDescription:
            "Jednostronna narracja bez kontekstu i alternatywnych poglądów.",
        description:
            "Struktura tekstu jest jednostronna, przedstawiając rzekome dążenia Ukraińców jako bezpośrednie zagrożenie dla Polski. Brak jest jakiegokolwiek kontekstu, niuansów czy alternatywnych perspektyw, co ma na celu manipulowanie opinią czytelnika.",
        status: CheckStatus.falseInfo,
      ),
    ],
  ),
  Flashcard(
    url: "https://twitter.com/adamSzlapka/status/1990351987926540649",
    answer: [
      Check(
        title: "Wiarygodność źródła",
        shortDescription:
            "Informacje o akcie dywersji i działaniach służb są potwierdzone.",
        description:
            "Wiele źródeł, w tym oficjalne komunikaty polityków oraz doniesienia medialne, potwierdza, że eksplozja na trasie Warszawa–Lublin została uznana za akt dywersji, a służby podjęły działania w celu ujęcia sprawców.",
        status: CheckStatus.verified,
      ),
      Check(
        title: "Jakość logiki",
        shortDescription: "Brak widocznych błędów logicznych czy manipulacji.",
        description:
            "Tekst przedstawia jednoznaczne stwierdzenia dotyczące wydarzenia i reakcji służb, bez błędów logicznych, nadinterpretacji czy prób manipulacji.",
        status: CheckStatus.verified,
      ),
      Check(
        title: "Presja emocjonalna",
        shortDescription:
            "Brak presji emocjonalnej czy prób wywołania strachu.",
        description:
            "Tekst utrzymany jest w tonie informacyjnym, bez użycia emocjonalnie nacechowanego słownictwa czy dramatyzacji.",
        status: CheckStatus.verified,
      ),
      Check(
        title: "Struktura manipulacyjna",
        shortDescription:
            "Struktura tekstu jest prosta, rzeczowa i informacyjna.",
        description:
            "Wypowiedź ma charakter informacyjny i nie wykorzystuje zabiegów manipulacyjnych takich jak jednostronna narracja, sensacyjność czy pomijanie istotnego kontekstu.",
        status: CheckStatus.verified,
      ),
    ],
  ),
];
