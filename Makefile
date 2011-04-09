build: clean
	@jekyll

clean: 
	rm -rf _site

server: clean
	jekyll --server --auto

publish: build
	@rsync -avz --exclude Makefile --exclude README.md _site serveradmin%liquidfoot.com@liquidfoot.com:domains/jekyll.liquidfoot.com
	
