{
	...
}: {
  home = {
	  file = {
		  ".gitconfig" = {
				source = ../generated/gitconfig;
			};
		  ".gitconfig-work" = {
				source = ../generated/gitconfig-work;
			};
		};
	};
	programs = {
		git.enable = true;
	};
}
