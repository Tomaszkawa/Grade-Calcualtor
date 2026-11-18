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

Podgląd w przeglądarce (zalecane — build release + prosty serwer HTTP):

```bash
flutter build web --release
python3 -m http.server 46123 --bind 0.0.0.0 --directory build/web
```

Potem otwórz: http://127.0.0.1:46123/ **na tym samym komputerze**, na którym uruchomiłeś serwer.

> `127.0.0.1` w przeglądarce na Twoim laptopie ≠ serwer w chmurze agenta.
> W Cursor Cloud użyj przekierowania portów (ikona wtyczki / Ports) albo GitHub Pages.
>
> `flutter run -d web-server` w trybie debug często wygląda na martwy podgląd
> (czeka na rozszerzenie Dart Debug) — używaj buildu release jak wyżej.

### GitHub Pages (publiczny podgląd)

Gałąź `gh-pages` z buildem web jest już w repozytorium. Włącz Pages:

1. Repo → **Settings** → **Pages**
2. Source: **Deploy from a branch**
3. Branch: `gh-pages` / folder `/ (root)` → Save

Adres: https://tomaszkawa.github.io/Grade-Calcualtor/

## Testy

```bash
flutter test
```

## Sprawozdanie

Szczegółowy opis realizacji: [SPRAWOZDANIE.md](./SPRAWOZDANIE.md)
