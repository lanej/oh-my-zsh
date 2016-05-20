# vim: ft=zsh
ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[white]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}]%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="]%{$reset_color%} "
ZSH_THEME_SVN_PROMPT_PREFIX=$ZSH_THEME_GIT_PROMPT_PREFIX
ZSH_THEME_SVN_PROMPT_SUFFIX=$ZSH_THEME_GIT_PROMPT_SUFFIX
ZSH_THEME_SVN_PROMPT_DIRTY=$ZSH_THEME_GIT_PROMPT_DIRTY
ZSH_THEME_SVN_PROMPT_CLEAN=$ZSH_THEME_GIT_PROMPT_CLEAN

prompt_context() {
	local user=`whoami`

	if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
		echo "$user@%m"
	fi
}

ruby_version() {
	local ruby_executable=`which ruby`
	local version=`ruby -v | awk '{print $2}'`

	if [[ $ruby_executable == '/usr/bin/ruby' ]]; then
		echo "system $version"
	else
		echo $version
	fi
}

vcs_status() {
	if [[ ( $(whence in_svn) != "" ) && ( $(in_svn) == 1 ) ]]; then
		svn_prompt_info
	else
		git_prompt_info
	fi
}

PROMPT='$(prompt_context) %2~ $(vcs_status) %{$fg[red]%}‹ruby-$(ruby_version)›%{$reset_color%}
%{$fg[cyan]%}[%?]%{$reset_color%} »%b '
RPROMPT=''
