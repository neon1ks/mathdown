http://mathdown.net
===================

Collaborative markdown with math.
Powered by [CodeMirror][], [MathJax][] and [Firebase][]'s [Firepad][].

[CodeMirror]: http://codemirror.net
[MathJax]: http://mathjax.org
[Firebase]: http://firebase.com
[Firepad]: http://firepad.io
[CodeMirror-MathJax]: http://github.com/cben/CodeMirror-MathJax

**Alpha quality – will eat your math, burn your bookmarks & expose your secrets.**

## License

My code is under [MIT License](LICENSE).

Dependencies:

 * CodeMirror is also MIT.
 * MathJax is under Apache License 2.0.
 * My [CodeMirror-MathJax][] glue is also MIT.
 * Firebase is a proprietary service (#4), but their clied-side APIs, and the collaborative editor [Firepad] are MIT.

## Git trivia

After checking out, run this to materialize subdirs:

    git submodule update --init --recursive

I'm directly working in gh-pages branch without a master branch, as that's the simplest thing that could possibly work (http://oli.jp/2011/github-pages-workflow/ lists several alternatives).

### Other things called "mathdown"

 * https://github.com/mayoff/Mathdown/tree/mathjax — Markdown.pl hacked for MathJax pass-through
 * https://github.com/keishi/kernlog/blob/master/markdown/extensions/mathdown.py
 * http://kwkbtr.info/log/201010050320 — a way to combine Showdown + Mathjax.
 * http://www.urbandictionary.com/define.php?term=mathdown
