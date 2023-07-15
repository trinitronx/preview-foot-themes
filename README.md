Preview Foot Themes
===================

A simple way to preview foot themes... without the _edit + restart_ loop 😎

[![Preview Foot Logo](./foot-theme-demo/preview-foot-logo.svg)](./foot-theme-demo/preview-foot-logo.svg)

Why?
----

`preview-foot-themes.sh` is a set of simple shell scripts to ease in the
process of previewing different themes for [`foot`][1].

The `foot` terminal [does not support reloading config files][2], as
you might expect. Instead, `OSC` commands are used which makes testing
out the different themes cumbersome.  This set of scripts aims to remedy
that.

Usage
-----

Simply run:

```shell
./preview-foot-themes.sh
```

Then, view & preview the themes. See built-in help for key bindings.
Press: `?` anytime for help

How does it work?! 🤔
--------------------

The `preview-foot-themes.sh` script launches fuzzy-find [`fzf`][3]
with the list of default themes for `foot`.  The preview window and
key/event bindings are set such that you can easily search & view themes.

The `launch-theme.sh` script is used as `fzf`'s preview command. It handles
the following:

1. Create a temp dir
2. Copy `~/.config/foot/foot.ini` to this temp dir
3. Modify the `include=` line, including the selected theme 
4. Launch `foot` with this config + run: `preview-terminal-colors.sh`
5. Wait 300ms & immediately cleanup the temp dir + config
  - This allows for faster theme switching,
  - Avoids `fzf` killing it prematurely (<500ms timeout), leaving stray tmpfiles
6. Sleep and print timeout to the `fzf` preview pane
7. Cleanup on exit & all normal trappable signals

The `preview-terminal-colors.sh` script runs `exa` to display the
`foot-theme-demo` directory with icons & decorations.  It then runs `neofetch`
to display the terminal colors amongst other distro & system details.

Dependencies
------------

This set of scripts depends on the following extra tools / utilities:

- `fzf`: [Fuzzy Find][3]
- `exa`: For previewing listed file colors + icons
  - Icons require a font that supports this... for example:
    [JetBrainsMono Nerd Font][4]
  - Zsh is recommended
- `neofetch`: For previewing the terminal colors + Distro details

... and of course: **`foot`!**

They also depend on some common POSIX utilities:

- `kill`
- `sed`
- `sync`
- `find`

[1]: https://codeberg.org/dnkl/foot
[2]: https://codeberg.org/dnkl/foot/issues/708
[3]: https://github.com/junegunn/fzf
[4]: https://github.com/ryanoasis/nerd-fonts
