# Sprawozdanie z laboratorium

**Przedmiot:** Programowanie aplikacji mobilnych  
**Temat:** Grade Calculator — kalkulator ocen (średnia ważona ECTS)  
**Poziom:** podstawowy–średni  
**Autor:** Tomasz Kawa  
**Repozytorium:** https://github.com/Tomaszkawa/Grade-Calcualtor

---

## 1. Cel ćwiczenia

Celem laboratorium było zaprojektowanie i zaimplementowanie aplikacji mobilnej we Flutterze do zarządzania ocenami studenta oraz obliczania średniej ważonej punktami ECTS.

Wersja podstawowa działa lokalnie (bez serwera i REST API). Dane przechowywane są wyłącznie w pamięci aplikacji (`List<Subject>` + `setState`).

## 2. Cele dydaktyczne — co zostało zrealizowane

| Cel | Realizacja |
|-----|------------|
| Interfejs z widgetów Fluttera | `Scaffold`, `AppBar`, `ListView.builder`, `Card`, `FloatingActionButton`, formularz |
| Model danych | Klasa `Subject` (`name`, `grade`, `ects`) |
| Formularze i walidacja | Ekran `AddSubjectScreen` z `Form` / `TextFormField` / `DropdownButtonFormField` |
| Dynamiczna lista | Dodawanie i usuwanie elementów listy |
| Stan przez `StatefulWidget` / `setState` | `HomeScreen` zarządza listą przedmiotów |
| Obliczenia w Dart | `GradeCalculator.weightedAverage` |
| Przekazywanie danych między ekranami | `Navigator.push` zwraca nowy `Subject` |

## 3. Wymagania funkcjonalne — checklist

- [x] Ekran główny: lista przedmiotów (nazwa, ocena, ECTS)
- [x] Aktualna średnia ważona oraz suma ECTS
- [x] Dodawanie przedmiotu przez osobny ekran formularza
- [x] Formularz: nazwa (niepusta), ocena z listy `2.0, 3.0, 3.5, 4.0, 4.5, 5.0`, ECTS (dodatnia liczba całkowita)
- [x] Usuwanie przedmiotu z natychmiastowym przeliczeniem średniej
- [x] Obsługa pustej listy i niepoprawnych danych bez awarii (wyświetlanie „—”, komunikaty walidacji)

## 4. Model danych

```dart
class Subject {
  final String name;
  final double grade;
  final int ects;

  const Subject({
    required this.name,
    required this.grade,
    required this.ects,
  });
}
```

W aplikacji wykorzystywana jest lokalna lista `List<Subject>`.

## 5. Algorytm obliczeń

\[
\text{średnia ważona} = \frac{\sum (\text{ocena} \times \text{ECTS})}{\sum \text{ECTS}}
\]

Dla pustej listy lub zerowej sumy ECTS aplikacja wyświetla **„—”** zamiast dzielenia przez zero.

### Przykład z polecenia

| Przedmiot       | Ocena | ECTS |
|-----------------|-------|------|
| Matematyka      | 4.5   | 6    |
| Programowanie   | 5.0   | 5    |
| Fizyka          | 3.5   | 4    |

\[
\frac{4{,}5 \times 6 + 5{,}0 \times 5 + 3{,}5 \times 4}{15} = \frac{66}{15} = 4{,}40
\]

Test jednostkowy `test/grade_calculator_test.dart` weryfikuje ten przypadek.

> Uwaga dydaktyczna z polecenia: regulamin uczelni może definiować średnią inaczej — tu stosowany jest model z laboratorium.

## 6. Struktura projektu

```
lib/
  main.dart
  models/subject.dart
  screens/home_screen.dart
  screens/add_subject_screen.dart
  widgets/subject_tile.dart
  utils/grade_calculator.dart
test/
  grade_calculator_test.dart
  widget_test.dart
```

Zgodna z proponowaną strukturą z instrukcji laboratoryjnej.

## 7. Przebieg realizacji (harmonogram 120 min)

| Czas        | Zadanie                                              | Status |
|-------------|------------------------------------------------------|--------|
| 0–15 min    | Projekt, katalogi, klasa `Subject`                   | ✔ |
| 15–40 min   | Ekran główny: `Scaffold`, `AppBar`, `ListView`, karty | ✔ |
| 40–65 min   | Formularz, walidacja, nawigacja                      | ✔ |
| 65–90 min   | Dodawanie/usuwanie, `setState`, średnia ważona       | ✔ |
| 90–110 min  | Testy: obliczenia, pusta lista, błędne dane          | ✔ |
| 110–120 min | Prezentacja / dokumentacja (to sprawozdanie)          | ✔ |

## 8. Testy

Uruchomienie:

```bash
flutter test
```

Pokryte przypadki:

1. Pusta lista → średnia `null` / wyświetlenie „—”
2. Zerowa suma ECTS → brak dzielenia przez zero
3. Przykład z polecenia → wynik `4.40`
4. Widget: dodanie przedmiotu z formularza aktualizuje listę i średnią
5. Widget: pusta nazwa blokowana walidacją

## 9. Uruchomienie aplikacji

```bash
flutter pub get
flutter run                 # Android / podłączone urządzenie
flutter run -d chrome       # podgląd web
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 46123
```

## 10. Zadania dodatkowe (opcjonalne — poza zakresem podstawowym)

Zgodnie z wskazówkami polecenia backend, baza i wykresy **nie są** wymaganiami podstawowymi. Możliwe rozszerzenia:

- symulator przyszłej średniej bez zapisu hipotetycznej oceny
- edycja istniejącego przedmiotu
- filtrowanie zaliczonych / niezaliczonych
- trwały zapis (`shared_preferences`)
- wykres rozkładu ocen

## 11. Wnioski

Aplikacja spełnia wymagania wersji podstawowej laboratorium: dwa ekrany, lokalna lista, formularz z walidacją, usuwanie przedmiotów oraz poprawne obliczanie średniej ważonej ECTS z bezpieczną obsługą pustych danych. Praca utrwala podstawowe wzorce Fluttera (`StatefulWidget`, nawigacja, formularze) bez wprowadzania zbędnej złożoności architektonicznej.
