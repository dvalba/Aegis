# Aegis

**Aegis** is a Flutter mobile app that helps dermatologists and clinics track patient skin-lesion cases with AI-assisted diagnosis.

It is the product version of the mobile app built for my bachelor's thesis in Computer Science (University of Havana). Rebranded, re-themed and restructured to be developed independently: the machine-learning inference runs on a backend service (no on-device model), so the app stays lightweight and the models can evolve without app releases.

## Features

- Patient and case management with local offline storage (Isar) and cloud sync via a REST API (Dio).
- Lesion records: clinical/histopathological diagnosis, body location (interactive body-part selector), phototype, commentary and dermoscopic imagery (picker + cropping).
- AI-assisted diagnosis (basal, melanoma, SCC and others) computed server-side and attached to each lesion with its confidence and model tag.
- Full case history, filters and per-patient views.
- Minimal black & white Material 3 UI.

## Architecture

Clean architecture with unidirectional data flow:

```
lib/
├── domain/          # Entities + repository interfaces (pure Dart)
├── infrastructure/  # Isar persistence, Dio HTTP, DTOs and mappers
├── presentation/    # Riverpod providers, go_router routes, screens and widgets
└── configs/         # Theme, environment, router, dropdowns
```

State management with **Riverpod** (Formz-style states), navigation with **go_router**, local database with **Isar**, HTTP with **Dio**.

## Getting started

1. Clone the repo.
2. Create your environment file:
   ```bash
   cp .env.template .env
   ```
   `API_URL` must point to a running backend exposing the API under `/api/v1`.
3. Run:
   ```bash
   flutter pub get
   flutter run
   ```

## Tech stack

Flutter, Dart, Riverpod, go_router, Isar, Dio, image_picker, image_cropper, Material 3.

## License

Proprietary — all rights reserved by David Alba.
