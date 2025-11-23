import 'educate_criterion.dart';

final List<EducateCriterion> criteria = [
  EducateCriterion(
    title: "Wiarygodność źródła",
    shortDescription: "Zweryfikuj źródła — czy da się to sprawdzić.",
    description:
        "Sprawdź każde powołane źródło: szukaj dat, dokumentów, cytatów i nazwisk. "
        "Porównaj informacje z oryginalnymi raportami lub oficjalnymi stronami. "
        "Jeśli tekst używa ogólników typu „mówią” — traktuj go jako niewystarczająco potwierdzony.",
    options: ["Wiarygodne", "Wątpliwe", "Niewiarygodne"],
  ),
  EducateCriterion(
    title: "Logika wypowiedzi",
    shortDescription: "Oceń spójność — czy wnioski wynikają z faktów.",
    description: "Przeanalizuj tok argumentacji krok po kroku. "
        "Wykrywaj fałszywe przyczynowości, nadinterpretacje і luki dowodowe.",
    options: ["Logiczne", "Częściowo logiczne", "Nielogiczne"],
  ),
  EducateCriterion(
    title: "Presja emocjonalna",
    shortDescription: "Zidentyfikuj emocje — oddziel uczucia od faktów.",
    description: "Zwróć uwagę na język budzący strach, litość lub szok. "
        "Usuń emocjonalną warstwę і sprawdź, jakie fakty naprawdę zostają.",
    options: ["Niska", "Średnia", "Wysoka"],
  ),
  EducateCriterion(
    title: "Manipulacyjna struktura tekstu",
    shortDescription:
        "Sprawdź układ — czy текст prowadzi do określonej reakcji.",
    description:
        "Przeanalizuj kolejność informacji, pominięcia kontekstu, sensacyjność "
        "i jednostronność. Zadaj pytanie: „Co zostało przemilczane?”",
    options: ["Brak", "Częściowa", "Wyraźna"],
  ),
];
