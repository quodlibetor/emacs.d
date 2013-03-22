# -*- mode: snippet -*-
# name: virtualenv dir locals
# key: virtualenv
# --
((nil . ((virtualenv-workon . "${1:`(file-name-nondirectory default-directory)`}")
	 (virtualenv-default-directory . "${2:`default-directory`}"))))
