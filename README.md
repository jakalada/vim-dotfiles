vim dotfiles
============

install
-------

``` sh
repos='The name of a new directory to clone into.'

git clone git://github.com/jakalada/vim-dotfiles.git $dir

ln -s $dir/_vimrc $HOME/.vimrc
ln -s $dir/_gvimrc $HOME/.gvimrc
ln -s $dir/_vim $HOME/.vim

cd $dir

# install plugins
git submodule init
git submodule update
```

add vim plugin
-----------------

``` sh
# delete suffix '.git'
git submodule add git://github.com/tpope/vim-pathogen.git _vim/bundle/vim-pathogen
```

remove modules
-----------------

``` sh
name='The name of a submodule you want to remove.'
git rm --cached `git config --file .gitmodules --get submodule.$name.path`
git config --file .gitmodules --remove-section submodule.$name
```

ref. <http://labs.timedia.co.jp/2011/03/git-removing-a-submodule.html>
