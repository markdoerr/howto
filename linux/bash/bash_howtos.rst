linux bash how-to
===========================

environment variables
_____________________

exporting

make changes availabel for current shell:


source ~/.bashrc
or you can use the shorter version of the command:

. ~/.bashrc

To complement and contrast the two most popular answers, . ~/.bashrc and exec bash:

Both solutions effectively reload ~/.bashrc, but there are differences:

source ~/.bashrc will preserve your current shell:
Except for the modifications that reloading ~/.bashrc into the current shell (sourcing) makes, the current shell and its state are preserved, which includes environment variables, shell variables, shell options, shell functions, and command history.
exec bash, or, more robustly, exec "$BASH"[1], will replace your current shell with a new instance, and therefore only preserve your current shell's environment variables (including ones you've defined ad-hoc).
In other words: Any ad-hoc changes to the current shell in terms of shell variables, shell functions, shell options, command history are lost.
Depending on your needs, one or the other approach may be preferred.
