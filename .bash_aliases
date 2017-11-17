alias l='ls -alF'
alias grr='git pull --rebase'
alias gr='git pull'
alias gs='git status'
alias gp='git push'
alias gd='git diff'
alias gds='git diff --staged'
alias gitc='git commit -a -m'
alias gitcm='git commit -m'
alias t='cd `mktemp -d`'
alias prove6='prove -e "perl6" -vr'
alias prove6l='prove -e "perl6 -Ilib" -vr'
alias zef='zef --debug'
alias cpanm='cpanm -v'
alias lel='ssh zoffix@perl6.party'
alias build-rakudo='perl Configure.pl --gen-moar --gen-nqp --backends=moar; make; make test; make install'
alias build-rakudo-no-tests='perl Configure.pl --gen-moar --gen-nqp --backends=moar; make; make install'
alias build-judo='perl Configure.pl --gen-nqp --backends=jvm; make; make test; make install'
alias build-judo-no-tests='perl Configure.pl --gen-nqp --backends=jvm; make; make install'
alias abc='perl6 -e '\''my $s = join q{ }, q{a} .. q{z}; $s.subst-mutate: :g, .lc, "»»»" ~ *.uc ~ "«««" for @*ARGS; $s.say'\'''
alias perlbrew-install-latest='perlbrew install perl-5.26.0 -Duseshrplib -Dusemultiplicity; perlbrew switch perl-5.26.0'
alias spec-remote='(cd t/spec && git remote remove origin && git remote add origin https://github.com/perl6/roast && git push --set-upstream origin master)'
alias irc="screen -r irc"
alias tree='tree -f'
alias tg='tree -f | grep -i '
alias sr='screen -r '
alias mi='make install'
p6() { if [[ -x ./perl6 && ! -d ./perl6 ]]; then ./perl6 "$@"; else command perl6 "$@"; fi; }

alias gcco='gcc -O -Wall -W -pedantic -ansi -std=c99 -o'
alias gc='perl6 -e '\''my ($prog, @args) = @*ARGS; with shell qq|gcc -O -Wall -W -pedantic -ansi -std=c99 -o "$prog" "$prog.c" && ./$prog @args[]| { exit .exitcode } '\'' '
g() { gcco "$@" "$@.c" && ./$@; }
ccc() {
    (
        cd $(mktemp -d);
        echo -e \
            '#include <stdio.h>\n'\
            '#include <stdbool.h>\n\n'\
            'int main(void) { ' > program.c;
        echo "$@" >> program.c;
        echo '; return 0; }' >> program.c;
        gcco program program.c; ./program;
    );
}
alias glop="git log --pretty=format:'%C(yellow)https://github.com/perl6/roast/commit/%H | %Cred%ad | %Cgreen%d %Creset%s' --date=short --reverse"

alias bump-it='rm -fr nqp && make clean &&
    git clone https://github.com/perl6/nqp/ &&
    cd nqp &&
    git clone https://github.com/MoarVM/MoarVM/ &&
    cd MoarVM &&
    git describe > ../tools/build/MOAR_REVISION &&
    cd ../ &&
    git commit -m '\''Bump MoarVM'\'' tools/build/MOAR_REVISION &&
    git describe > ../tools/build/NQP_REVISION &&
    cd ../ &&
    git commit -m '\''Bump NQP'\'' tools/build/NQP_REVISION &&
    perl Configure.pl --gen-moar --gen-nqp --backends=moar &&
    make &&
    make test &&
    make install &&
    make stresstest && cd nqp && git checkout master &&
    git push && cd .. && git push
    
'
alias bump-push='cd nqp && git checkout master && git push && cd .. && git push'


### .bashrc stuff

source ~/perl5/perlbrew/etc/bashrc
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
shell_name() { if [ "$SN" ]; then echo "$SN "; else echo ""; fi; }
export PS1="\033[33m\$(shell_name)\033[00m\u@\h\[\033[32m\]\w\[\033[34m\]\$(parse_git_branch)\[\033[00m\]$ "
export PATH="$HOME/rakudo/install/bin:$HOME/rakudo/install/share/perl6/site/bin:$PATH"
alias update-perl6='
    cd ~/rakudo;
    git pull;
    perl Configure.pl --gen-moar --gen-nqp --backends=moar;
    make;
    make test;
    make install'
