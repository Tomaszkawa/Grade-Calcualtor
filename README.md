# Grade Calculator — kalkulator ocen

Aplikacja mobilna Flutter do zarządzania ocenami studenta i obliczania **średniej ważonej ECTS**.

Laboratorium: *Programowanie aplikacji mobilnych* (poziom podstawowy–średni).

## Funkcje (wersja podstawowa)

- lista przedmiotów (nazwa, ocena, ECTS)
- dodawanie przedmiotu na osobnym ekranie formularza
- ocena wybierana z listy: 2.0 · 3.0 · 3.5 · 4.0 · 4.5 · 5.0
- walidacja nazwy i dodatnich punktów ECTS
- usuwanie przedmiotu z natychmiastowym przeliczeniem średniej
- pusta lista → wyświetlenie „—” zamiast dzielenia przez zero
- dane tylko w pamięci aplikacji (bez serwera / REST API)

## Struktura

```
lib/
  main.dart
  models/subject.dart
  screens/home_screen.dart
  screens/add_subject_screen.dart
  widgets/subject_tile.dart
  utils/grade_calculator.dart
```

## Wymagania

- Flutter SDK 3.35+ (`flutter doctor`)

## Uruchomienie

```bash
flutter pub get
flutter run
```

Podgląd w przeglądarce:

```bash
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 46123
```

## Testy

```bash
flutter test
```

## Sprawozdanie

Szczegółowy opis realizacji: [SPRAWOZDANIE.md](./SPRAWOZDANIE.md)
