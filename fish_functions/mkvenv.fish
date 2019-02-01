function mkvenv
	virtualenv --python=$argv[1] ~/.venvs/$argv[2]
end
