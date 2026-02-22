# dotfiles

Personal configuration files and agent skills, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Table of Contents

- [Agent Skills](#agent-skills)
- [Setup](#setup)
  - [Install symlinks](#install-symlinks)
  - [Conflicts](#conflicts)
  - [Re-stow after changes](#re-stow-after-changes)

## Agent Skills

Agent skills live under `.agents/skills/`.

| Skill | Source | Description |
|---|---|---|
| `pilotty` | [msmps/pilotty](https://github.com/msmps/pilotty) | Terminal TUI automation through managed PTY sessions |
| `opentui` | [msmps/opentui-skill](https://github.com/msmps/opentui-skill) | Building terminal user interfaces with OpenTUI |
| `build-skill` | Fork of [dmmulroy/build-skill](https://github.com/dmmulroy/build-skill) | Modified with updated file size guidelines, progressive disclosure patterns, and platform skill docs aligned to real-world reference implementations |

## Setup

```sh
git clone git@github.com:msmps/dotfiles.git ~/dotfiles
```

### Install symlinks

Stow creates symlinks in `~` mirroring the directory structure of this repo. From within the repo:

```sh
cd ~/dotfiles
stow .
```

This will create symlinks like `~/.zshrc -> dotfiles/.zshrc`, `~/.agents -> dotfiles/.agents`, etc.

### Conflicts

If stow reports conflicts because a target already exists as a real file or directory, remove (or back up) the conflicting path first:

```sh
rm -rf ~/.agents   # or mv ~/.agents ~/.agents.bak
cd ~/dotfiles
stow .
```

### Re-stow after changes

After adding or restructuring files in the repo, re-run stow to update symlinks:

```sh
cd ~/dotfiles
stow --restow .
```
