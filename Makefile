MAKELOCL:=$(shell mkdir -p `pwd`/texmf)
IMG=docker.io/pandoc/latex:latest
OPTS+= --rm -it 
OPTS+= -v ${PWD}:/data/cmd -w /data/cmd 
OPTS+= --name texlive_`echo $$$$`
OPTS+= -e HOSTUSER=`id -un`
OPTS+= -v /etc/group:/etc/group:ro
OPTS+= -v /etc/passwd:/etc/passwd:ro
OPTS+= -v /etc/shadow:/etc/shadow:ro
OPTS+= -v /usr/share/fonts:/usr/share/fonts:ro
OPTS+= -v `pwd`/texmf:$(HOME)/texmf
OPTS+= --entrypoint "/data/cmd/entrypoint.sh"
PANDOC=docker run $(OPTS)  $(IMG) pandoc


build:
	$(PANDOC) --defaults default.yaml

clean:
	rm -Rf *.log *.aux *.dvi *.pdf *.glo *.hd *.idx *.out .uuid .sudoer
