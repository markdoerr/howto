
# tmux howto

acknowledgements
thanks also to Henrik (https://gist.github.com/henrik/1967800)


start new:

    tmux

start new with session name:

    tmux new -s myname

attach:

    tmux a  #  (or at, or attach)

attach to named:

    tmux a -t myname

list sessions:

    tmux ls

kill session:

    tmux kill-session -t myname

In tmux, hit the prefix `ctrl+b` and then:

## Sessions

    :new<CR>  new session
    s  list sessions
    $  name session

## Windows (tabs)

    c           new window
    ,           name window
    w           list windows
    f           find window
    &           kill window
    .           move window - prompted for a new number
    :movew<CR>  move window to the next unused number

## Panes (splits)

    %  horizontal split
    "  vertical split
    
    o  swap panes
    q  show pane numbers
    x  kill pane
    ⍽  space - toggle between layouts

## Window/pane surgery

    :joinp -s :2<CR>  move window 2 into a new pane in the current window
    :joinp -t :1<CR>  move the current pane into a new pane in window 1

* [Move window to pane](http://unix.stackexchange.com/questions/14300/tmux-move-window-to-pane)
* [How to reorder windows](http://superuser.com/questions/343572/tmux-how-do-i-reorder-my-windows)

## Misc

    d  detach
    t  big clock
    ?  list shortcuts
    :  prompt

Resources:

* [cheat sheet](http://cheat.errtheblog.com/s/tmux/)

Notes:

* You can cmd+click URLs to open in iTerm.


## splitting panels

ctrl-b %

## creating/deleting new panels

create: ctrl-b c
kill:   ctrl-b x

## renaming

ctrl-b : rename-window [new name]

## copy / paste

with the default tmux prefix Control+b and default emacs style key bindings on

1) enter copy mode using Control+b [
2) navigate to beginning of text, you want to select and hit Control+Space
3) move around using arrow keys to select region
4) when you reach end of region simply hit Alt+w to copy the region
5) now Control+b ] will paste the selection

you can navigate the text using the emacs style navigation key
Control+p, Control+n, Control+f, Control+b etc.

if you have vi style key bindings on then the following applies:

1) enter copy mode using Control+b [
2) navigate to beginning of text, you want to select and hit Space
3) move around using arrow keys to select region
4) when you reach end of region simply hit Enter to copy the region
5) now Control+b ] will paste the selection

To enable vi like cursor movement in copy mode put the following in your ~/.tmux.conf:
	
set-window-option -g mode-keys vi

more over what ever you copy, you may dump that out in your terminal using
	
tmux show-buffer

and even save to a file(say, foo.txt) using
	
tmux save-buffer foo.txt

To see all the paste buffers try Control + b #. To dump out the varios buffers on to the terminal or file you may use
	
tmux list-buffers
tmux show-buffer -b n
tmux save-buffer -b n foo.txt

where n is the index of the paste buffer.


