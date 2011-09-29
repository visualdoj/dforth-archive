LOPTION(evaluate, READ_PARAM; AddFileName(PARAM);)
LOPTION(repl, SETOPT(Repl, True);)
LOPTION(norepl, SETOPT(Repl, False);)
LOPTION(system, READ_PARAM; SETOPT(System, PARAM);)

MOPTION(e, READ_PARAM; AddFileName(PARAM);)
MOPTION(r, SETOPT(Repl, False);)
MOPTION(s, SETOPT(System, '');)
MOPTION(h, PrintHelp;)

POPTION(r, SETOPT(Repl, True);)
POPTION(s, READ_PARAM; SETOPT(System, PARAM);)
