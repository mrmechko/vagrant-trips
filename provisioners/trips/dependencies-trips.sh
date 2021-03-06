#!/bin/bash
# code dependencies

# install java8
sudo apt-get install -y openjdk-8-jdk


# sbcl cvs ruby sqlite graphviz
sudo apt-get install -y sbcl cvs ruby libdbd-sqlite3-perl graphviz unzip lighttpd xsltproc


mkdir -p ~/bin
cd bin
curl -L https://cpanmin.us/ -o cpanm
chmod +x cpanm

cd ~
sudo ~/bin/cpanm CGI

mkdir -p $TRIPSDEP


link_deps() {
	# symlink things to the right place
	cd $TRIPSDEP
	unzip dependencies.zip

	cd tripsDependencies

	SOURCE=`pwd`

	#cj-parser   mesh      stanford-ner    stanford-postagger
	#geonames    stanford-corenlp  stanford-parser

	#ln -s $SOURCE/tripsDependencies/$f $f

	ln -sv $SOURCE/stanford-ner/stanford-ner-2007-11-05 $SOURCE/stanford-ner/stanford-ner
	ln -sv $SOURCE/stanford-postagger/stanford-postagger-2008-06-06/ $SOURCE/stanford-postagger/stanford-postagger

	ln -sv $SOURCE/stanford-parser/stanford-parser-2007-08-19/ $SOURCE/stanford-parser/stanford-parser
	ln -sv $SOURCE/stanford-corenlp/stanford-corenlp-full-2014-06-16/ $SOURCE/stanford-corenlp/stanford-corenlp
}


DEPURL="http://github.com/mrmechko/vagrant-trips/releases/download/0.0.1/tripsDependencies.zip"

if [ ! -f $TRIPSDEP/dependencies.zip ]; then
	curl -L $DEPURL > $TRIPSDEP/dependencies.zip
	#cp ~/shared/dependencies.zip $TRIPSDEP/dependencies.zip
	echo "export TRIPSDEP=$TRIPSDEP" >> /home/vagrant/.bash_profile
	echo "linking"
	link_deps
fi



cd ~/shared/step/src/config
curl -L "https://github.com/tripslab/vagrant-trips/releases/download/0.0.2/ruby.tar" > ruby.tar
tar xf ruby.tar
rm ruby.tar

cd ~/shared/step/src && git -C /home/vagrant/shared/step/src/jsontrips pull || git clone https://github.com/mrmechko/jsontrips
cd ~/shared/step/src && git -C /home/vagrant/shared/step/src/WebParser pull || git clone https://github.com/tripslab/WebParser
