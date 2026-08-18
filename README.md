# Mess Manager

A Flutter app for managing a shared mess/hostel: member dues, meal tracking,
expenses, and monthly billing. Built with Clean Architecture, `flutter_bloc`
for state management, `go_router` for navigation, and `get_it` for
dependency injection.

## Tech stack

| Concern              | Package                                    |
|-----------------------|---------------------------------------------|
| State management      | `flutter_bloc` (Bloc for auth, Cubit elsewhere) |
| Dependency injection  | `get_it`                                     |
| Routing               | `go_router`                                  |
| Networking            | `http`                                       |
| Responsive UI         | `flutter_screenutil`                         |
| Charts                | `fl_chart`                                   |
| Images                | `cached_network_image`                       |
| Testing               | `flutter_test`, `bloc_test`, `mocktail`      |

## Architecture

Each feature under `lib/features/` is a self-contained module split into
three layers, following Clean Architecture:

```
feature/
├── data/            # Concrete implementations — talks to APIs/local storage
│   ├── datasources/ #   raw data access (remote/local)
│   ├── models/      #   DTOs, (de)serialize from/to JSON
│   └── repositories/#   implements the domain repository contract
├── domain/          # Pure Dart, no Flutter/HTTP imports — the business rules
│   ├── entities/    #   domain objects
│   ├── repositories/#   abstract contracts the data layer must satisfy
│   └── usecases/    #   one class per business operation, called by presentation
├── presentation/    # UI layer
│   ├── bloc/ or cubit/ #  state containers, call usecases
│   ├── pages/       #   screens
│   └── widgets/     #   feature-local, non-shared widgets
└── injection_container.dart   # registers this feature's dependencies into get_it
```

Dependency rule: `presentation → domain ← data`. The domain layer never
imports from `data` or `presentation`; `data` implements the interfaces
`domain` declares. This is what lets a usecase be unit-tested with a mocked
repository (see `test/features/*/`) without touching Flutter or HTTP.

Cross-feature/shared code lives in `lib/core/` — nothing feature-specific
belongs there.

## Project structure

```
lib/
├── main.dart                      # entrypoint: sets up DI, builds the router once, runs MyApp
│
├── core/                          # shared across every feature
│   ├── constants/                 # app-wide string/asset constants (AppString, AppImages)
│   ├── di/                        # service_locator.dart — root get_it setup, calls each
│   │                               feature's injection_container()
│   ├── enums/                     # shared enums (e.g. UserRole)
│   ├── error/                     # Failure / Result / exception types used across layers
│   ├── network/                   # api_client.dart — shared HTTP client wrapper
│   ├── routes/                    # go_router config: AppRoute (route names),
│   │                               app_page.dart (GoRouter + role-based auth redirect),
│   │                               go_router_refresh_stream.dart (rebuilds router on auth change)
│   ├── theme/                     # AppColor, AppStyle, Dimensions, ThemeData
│   └── widgets/                   # shared widgets (buttons, app bar, dialogs, loaders)
│
├── features/
│   ├── auth/                      # sign in / sign up / session
│   │   ├── data/                  #   auth_local_data_source, login/sign-up models, repo impl
│   │   ├── domain/                #   AuthUser entity, AuthRepository contract,
│   │   │                          #   login/sign-up/logout/check-session usecases
│   │   ├── presentation/
│   │   │   ├── bloc/              #   AuthBloc — the one Bloc in the app (long-lived, app-scoped)
│   │   │   ├── pages/             #   sign_in.dart, sign_up.dart
│   │   │   └── widgets/           #   shared auth form pieces
│   │   └── injection_container.dart
│   │
│   ├── dashboard/                 # member home: balance, operations, meal list,
│   │   │                          # monthly summary, wallet, transaction history
│   │   ├── data/  domain/  presentation/{cubit,pages,widgets}
│   │   └── injection_container.dart
│   │
│   ├── manager/                   # manager-only: add expense/meal/shared-expense,
│   │   │                          # expense list, summary + pie chart
│   │   ├── data/  domain/  presentation/{cubit,pages,widgets}
│   │   └── injection_container.dart
│   │
│   ├── members/                   # member list — view/update/delete members
│   │   ├── data/  domain/  presentation/{cubit,pages}
│   │   └── injection_container.dart
│   │
│   ├── profile/                   # current user's profile
│   │   ├── data/  domain/  presentation/{cubit,pages,widgets}
│   │   └── injection_container.dart
│   │
│   ├── splash/                    # boot screen — resolves session before first route
│   │   ├── presentation/{cubit,pages}
│   │   └── injection_container.dart
│   │
│   └── main/
│       └── main.dart              # the persistent bottom-nav shell (tabs), not the app entrypoint
│
test/
├── features/
│   ├── auth/login_usecase_test.dart
│   ├── manager/add_expense_usecase_test.dart
│   └── members/members_usecases_test.dart
└── widget_test.dart                # smoke test: app boots to splash
```

`features/dashboard`, `features/manager`, `features/members`, and
`features/profile` each follow the same `data/domain/presentation` split
shown in full for `auth` above; they're collapsed here to keep this map
readable.

## Routing & access control

Routes are declared as constants in `core/routes/app_route.dart` and wired
up in `core/routes/app_page.dart`, which also holds `_authRedirect` — a
single `GoRouter.redirect` that:
- sends unauthenticated users to `AppRoute.login` for any non-auth route,
- sends authenticated users away from the login/sign-up routes,
- blocks members from manager-only routes (`_managerOnlyRoutes`) even via
  direct/deep-link navigation.

`go_router_refresh_stream.dart` re-evaluates that redirect whenever
`AuthBloc`'s state changes, so a login/logout immediately reroutes without
a manual `context.go(...)` call at the call site.

## State management conventions

- **`AuthBloc`** is the only Bloc — it's app-scoped (provided once in
  `main.dart`, above the router) and event-driven because auth has
  discrete triggers (login, logout, session check).
- Every other feature uses a **Cubit** — simpler surface for
  screen-scoped state that's mostly "load / react to a filter change."
- `BlocBuilder`/`BlocListener` calls use `buildWhen`/`listenWhen` where a
  widget only cares about one field of a larger state, to avoid rebuilding
  on unrelated state changes.

## Dependency injection

`core/di/service_locator.dart` is the single entrypoint called from
`main()`. It registers app-wide singletons (API client, shared
repositories) and then delegates to each feature's own
`injection_container.dart` to register that feature's data sources,
repositories, usecases, and Bloc/Cubit — so a feature's DI wiring lives
next to the feature itself, not in one growing global file.

## Testing

Usecase tests (`test/features/*/`) mock the domain repository with
`mocktail` and assert the usecase forwards params and surfaces
`Result`/`Failure` correctly — no Flutter, HTTP, or storage involved,
which is only possible because usecases depend on the abstract
repository, not its implementation.

Run everything:

```bash
flutter pub get
flutter analyze
flutter test
```

## Getting started

```bash
flutter pub get
flutter run
```
