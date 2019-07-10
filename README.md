# pseudo.sty

The **pseudo** package permits writing pseudocode without much fuss and with
quite a bit of configurability. Its main environment combines aspects of
`enumeration`, `tabbing` and `tabular` for nonintrusive line numbering,
indentation and highlighting, and there is functionality for typesetting
common syntactic elements such as keywords, identifiers and comments.

The package is written by [Magnus Lie Hetland](mailto:mlh@ntnu.no) and
released under the [MIT license](LICENSE).

## Using pseudo

You can find more detailed instructions in [the
documentation](doc/pseudo.pdf), but it's really quite simple to get started.
The package is [available via CTAN](https://ctan.org/pkg/pseudo), and so is
part of several TeX distributions. If the newest version isn't in yours, try
to run an update. In TeX Live, for example, you could run use the [TeX Live
Utility](http://amaxwell.github.io/tlutility/) (part of distributions such as
[MacTeX](https://tug.org/mactex/)). Alternatively, you can just download the
[pseudo.sty](pseudo.sty) file and drop it where your `latex` can find it
(possibly just in the same directory as your document).

Assuming you want numbered lines (the default) and have most text set as
keywords (set by the `kw` switch), you simply import **pseudo** using

```tex
\usepackage[kw]{pseudo}
```

and then set your pseudocode in a `pseudo` environment. Lines are terminated
by the normal `\\` command, which may be extended with one or more pluses or
minuses to indicate a change in indentation level. You suppress the automatic
numbering of the following line using a star (i.e., either `\\*`, or
`\begin{pseudo}*`), and can typeset a procedure header using `\hd{Name}(...)`.
For [example](https://mipmip.org/tidbits/pasa.pdf):

```tex
\begin{pseudo}*

    \hd{Backward}(V, E, v, i)              \\

    $v.\id{label} = i$                     \\

    for $(u,v)\in E$                       \\+
        if $0 < v.\id{label} < i$          \\+
            \pr{Backward}(V, E, u, i)      \\--

    for $(u,v)\in E$                       \\+
        if $u.\id{label} = 0$              \\+
            \pr{Backward}(V, E, u, i+1)

\end{pseudo}
```

This produces:

<img src="doc/fig/readmefig.svg"/>

There is also a starred version of the environment (`pseudo*`), which
is unnumbered.

The commands `\pr` and `\id` indicate procedure calls and identifiers.
If we hadn't used the `kw` option, the main text would not be set as keywords,
but as plain text. We could then use `\kw` to mark up keywords. Some of these
may be used a lot, so I might want to declare a shortcut. For example, if
I use

```tex
\DeclarePseudoKeyword \While {while}
```

I'd be able to use `\While` rather than `\kw{while}` later. Several such
formatting and declaration commands exist:

| Type of text | Command             | Declaration                                     |
| ------------ | ------------------- | ----------------------------------------------- |
| Keywords     | `\kw{while}`        | `\DeclarePseudoKeyword \While {while}`          |
| Constants    | `\cn{false}`        | `\DeclarePseudoConstant \False {false}`         |
| Identifiers  | `\id{rank}`         | `\DeclarePseudoIdentifier \Rank {rank}`         |
| Strings      | `\st{Hello!}`       | `\DeclarePseudoString \Hello {Hello!}`          |
| Procedures   | `\pr{Euclid}(a, b)` | `\DeclarePseudoProcedure \Euclid {Euclid}`      |
| Functions    | `\fn{length}(A)`    | `\DeclarePseudoFunction \Length {length}`       |
| Comments     | `\ct{Important!}`   | `\DeclarePseudoComment \Important {Important!}` |

For normal text (e.g., when using the `kw` switch), there is also `\tn` (along
with `\DeclarePseudoNormal`).

Since the short names of these commands are prone to collisions with other
packages, **pseudo** won't insist on using them. If you import **pseudo**
*after* some other package that already uses, say, `\id`, then **pseudo**
won't define it. All of these are still available with the `pseudo` prefix,
however (e.g., `\pseudoid`), and the declaration commands still work.

Beyond the styling of text, there are also the `\==` and `\..` commands
(also written `\eqs` and `\dts`) for typesetting double equals sign and double
dots.

This covers most of the core functionality, but there are also more obscure
features (such as dimming or highlighting lines) and a host of configuration
keys for getting the pseudocode looking more like you'd want it to. For
details, consult [the documentation](doc/pseudo.pdf).
