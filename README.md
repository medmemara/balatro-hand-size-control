# Hand Size Control

A small [Steamodded](https://github.com/Steamodded/smods) mod for Balatro that changes only the **starting hand size** of new runs.

## Modes

- **Minimum**: keeps the deck and Sleeve effects, but raises the starting hand size to the selected value when it would otherwise be lower.
- **Fixed**: sets the starting hand size to the selected value, overriding the deck and Sleeve starting hand-size effects.

Choose a value from **1 to 50 cards**. The default is **Minimum 8**, which preserves a normal run while preventing a reduced starting hand size.

This mod does not change the number of cards that can be played in a hand (normally 5), Blind targets, scoring, Joker slots, or any other game setting. It also does not undo hand-size changes earned or lost after a run begins, such as Ectoplasm.

## Current runs

The Config screen includes **Apply to current run**. It changes the live hand-size limit without restarting or abandoning the run. Increasing the limit draws additional cards immediately when Balatro is at a normal draw or hand-selection state; reducing the limit takes effect on the next draw so cards currently visible are not discarded.

## Requirements

- Balatro
- [Lovely](https://github.com/ethangreen-dev/lovely-injector) 0.9.0 or newer
- [Steamodded](https://github.com/Steamodded/smods) `1.0.0~BETA-1814a` or newer

## Installation

1. Download the latest release ZIP.
2. Extract the `HandSizeControl` folder into the Balatro `Mods` directory.
3. Launch Balatro through Lovely.
4. Open **Mods → Hand Size Control → Config**, choose `Minimum` or `Fixed`, and choose the number of cards.
5. Start a **new run**, or use **Apply to current run** for an existing run.

## macOS

Steamodded's Mods directory is normally:

```text
~/Library/Application Support/Balatro/Mods
```

The local-development setup may point `Mods/HandSizeControl` at this repository with a symbolic link. Keep the repository in place while using that link.
