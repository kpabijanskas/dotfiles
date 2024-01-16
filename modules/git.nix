{
	...
}: {
  home = {
	  file = {
		  ".gitconfig" = {
				source = ../generated/gitconfig;
			};
		};
	};
	programs = {
		git.enable = true;
	};
}
