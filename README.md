# homebrew-tap

Homebrew tap for [magna-nz](https://github.com/magna-nz) projects.

## forgetop

Keyboard-driven terminal UI for PRs, work items, and CI across six forges.
→ [magna-nz/forgetop](https://github.com/magna-nz/forgetop)

```sh
brew install magna-nz/tap/forgetop
```

## remuda

Chat-first desktop UI for Ollama. Apple Silicon, macOS 12+.
→ [magna-nz/remuda](https://github.com/magna-nz/remuda)

```sh
brew install --cask magna-nz/tap/remuda
```

## About this tap

`magna-nz/tap` is Homebrew shorthand for this repo — `homebrew-tap` with the
`homebrew-` prefix dropped.

forgetop is a CLI binary, so it ships as a **formula** in `Formula/`. remuda
is a GUI `.app`, so it ships as a **cask** in `Casks/`. Homebrew looks in the
two directories separately, so they never collide.

Nothing here is edited by hand. Each project's release workflow renders its
own formula or cask and pushes it after publishing a GitHub release, so the
`url` here always points at an asset that already exists:

- forgetop — [cargo-dist](https://axodotdev.github.io/cargo-dist) generates
  the workflow and renders the formula
- remuda — a hand-written workflow, since cargo-dist has no notion of a
  Tauri `.app` bundle or a cask

To report a problem, open an issue on the project's own repo rather than
this one.
