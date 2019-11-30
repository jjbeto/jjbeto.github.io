.POSIX:
DESTDIR=public
HUGO_VERSION=0.59.1

OPTIMIZE = find $(DESTDIR) -not -path "*/static/*" \( -name '*.png' -o -name '*.jpg' -o -name '*.jpeg' \) -print0 | \
xargs -0 -P8 -n2 mogrify -strip -thumbnail '1000>'

.PHONY: all
all: get_repository clean get build test cname deploy

.PHONY: get_repository
get_repository:
	@echo "🛎 Getting Pages repository"
	git checkout source
	git submodule update --init --recursive
	git clone https://$(TOKEN)@github.com/jjbeto/jjbeto.github.io.git $(DESTDIR)

.PHONY: clean
clean:
	@echo "🧹 Cleaning old build"
	cd $(DESTDIR) && rm -rf *

.PHONY: get
get:
	@echo "❓ Checking for hugo"
	@if ! [ -x "$$(command -v hugo)" ]; then\
		echo "🤵 Getting Hugo";\
	    wget -q -P tmp/ https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz;\
		tar xf tmp/hugo_extended_$(HUGO_VERSION)_Linux-64bit.tar.gz -C tmp/;\
		sudo mv -f tmp/hugo /usr/bin/;\
		rm -rf tmp/;\
		hugo version;\
	fi

.PHONY: build
build:
	@echo "🍳 Generating site"
	hugo --gc --minify -d $(DESTDIR)

	@echo "🧂 Optimizing images"
	$(OPTIMIZE)

.PHONY: test
test:
	@echo "🍜 Testing HTML"
	docker run -v $(GITHUB_WORKSPACE)/$(DESTDIR)/:/mnt 18fgsa/html-proofer mnt --disable-external

.PHONY: cname
test:
	@echo "🔗 Generate CNAME"
	echo "jjbeto.com" > $(DESTDIR)/CNAME

.PHONY: deploy
deploy:
	@echo "🎁 Preparing commit"
	@cd $(DESTDIR) \
	&& git config user.email "jbeto@gmail.com" \
	&& git config user.name "jjbeto via GitHub Actions" \
	&& git add . \
	&& git status \
	&& git commit -m "🤖 CD bot is helping" \
	&& git push -u origin master
	@echo "🚀 Site is deployed!"
