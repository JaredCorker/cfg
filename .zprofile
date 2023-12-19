eval "$(/opt/homebrew/bin/brew shellenv)"
export REA_AS_MFA_METHOD=OKTA_PUSH
alias vim="nvim"
alias n="nvim"
alias nvimz="nvim ~/.zprofile"
alias lg="lazygit"
alias sp="source ~/.zprofile && echo 'Sourced ~/.zprofile'"
alias la="ls -a"
alias cl="clear"
alias cll="clear; ls"
alias cla="clear; la"
alias cls="clear; gs"
alias cld="clear; d"
alias t="tmux"
alias tks="tmux kill-server"
alias gs="git status"
alias gd="git diff"
alias gf="git fetch"
alias gp="git pull"
alias gfp="git fetch; git pull"
alias gbc="git rev-parse --abbrev-ref HEAD"
alias showgit="cat ~/.oh-my-zsh/plugins/git/git.plugin.zsh | grep 'alias'"
function gco() {
	git checkout "$1"
}
alias d="yarn dev"
alias ct="yarn check-types"
alias ctw="yarn check-types-watch"
function tn() {
  tmux new -s "$1"
}
alias cdcore="cd ~/Documents/REAx/pca-core-web/src"
alias cdexp="cd ~/Documents/REAx/pca-experience-api/src"
alias startcore="cd ~/Documents/REAx/pca-core-web/src && yarn dev"
alias codecore="code ~/Documents/REAx/pca-core-web"
alias startexp="cd ~/Documents/REAx/pca-experience-api/src && yarn dev"
alias codeexp="code ~/Documents/REAx/pca-experience-api"
alias cdnvim="cd ~/.config/nvim"
alias gpf="git push --force-with-lease"
function alc() {
  git add .
  git commit --amend --no-edit
  git push --force-with-lease
}
alias tunnel="rea-as okta property-com-au-ReadWrite -- ~/Documents/REAx/fargate-bastion/fargate-bastion subnet-0cd3045256a67d382 \
  --tunnel '3500:pca-property-data-api-prod.property-research-prod.property.com.au:443'"
alias tunnel-redeploy="rea-as okta property-com-au-ReadWrite -- ~/Documents/REAx/fargate-bastion/fargate-bastion --redeploy subnet-0cd3045256a67d382 \
  --tunnel '3500:pca-property-data-api-prod.property-research-prod.property.com.au:443'"
alias tunnelGraphiql="rea-as okta property-com-au-ReadWrite -- ~/Documents/REAx/fargate-bastion/fargate-bastion subnet-0cd3045256a67d382 \
  --tunnel '3001:pca-property-data-api-prod.property-research-prod.property.com.au:443'"
alias nc='cd ~/.config/$(ls ~/.config/ | fzf) && nvim'
function unzipsitemaps() {
  for d in ./*/; do
    (cd "$d" && for x in sitemap-[0-9].xml.gz; do
      gzip -dk "$x";
    done);
  done
}
function countsitemaps() {
  for d in ./*/; do 
    (cd "$d" &&
      directoryTotal=$(printf "%'d\n" $(grep -r -o https | wc -l));
      echo "$d $directoryTotal" &&
      for x in sitemap-[0-9].xml; do
        fileTotal=$(printf "%'d\n" $(grep -o https $x | wc -l));
        echo "$x $fileTotal";
      done);
  done
  total=$(printf "%'d\n" $(grep -r -o https | wc -l))
  echo "Total: $total"
}
# Run tests
function test() {
  CORE_WEB="pca-core-web"
  XAPI="pca-experience-api"
  REDIRECT="pca-redirect-api"
  watch=false
  check=false

  while getopts 'wc' flag ; do
    case "$flag" in
      w) watch=true ;;
      c) check=true ;;
      *) echo "Invalid option: -$flag" ;;
    esac
  done

  if [[ "$PWD" == *"$CORE_WEB"* ]]; then
    if $watch;
    then
      yarn client-test-watch
    elif $check;
    then
      yarn client-test-watch $(find ~/Documents/REAx/pca-core-web/src -type f -name '*.spec.ts' -o -name '*.spec.tsx' | fzf)
    else
      yarn client-test
    fi
    return
  fi

  if [[ "$PWD" == *"$XAPI"* ]]; then
    if $watch;
    then
      yarn unit-test-w
    elif $check;
    then
      yarn unit-test-w $(find ~/Documents/REAx/pca-experience-api/src -type f -name '*.spec.ts' -o -name '*.spec.tsx' | fzf)
    else
      yarn unit-test
    fi
    return
  fi

  if [[ "$PWD" == *"$REDIRECT"* ]]; then
    yarn test
    return
  fi

  echo "Cant run tests, not in x-api, core-web or redirect-api"
}
alias itest="yarn integration-test"
alias itestw="yarn integration-test --watch"
alias itesto="yarn integration-test:open"
alias lint="yarn lint"
alias lintcss="yarn lint:css"
alias nq="networkquality"
alias cg="yarn codegen"
alias cga="yarn codegen-api"

function tt() {
	cdcore;
	tmux new-session -d -s core;
	cdexp;
	tmux new-session -d -s exp;
	cd;
	tmux new-session -d -s tunnel;
	tmux new-session -d -s misc;
	tmux attach-session -t tunnel;
}
function check() {
	git checkout $(git branch -l | fzf);
}
function checka() {
	git checkout $(git branch -a | fzf);
}
alias nvimc="nvim ~/.config/nvim/init.lua"
alias cdc="cd ~/.config/nvim"
alias bsl="brew services list"
alias gdl="git diff HEAD^ HEAD"
alias cdp='cd ~/Documents/REAx/$(ls ~/Documents/REAx | fzf)'
alias cdd='cd && clear'
function dropstash() {
  for i in {1..$1}; do git stash drop 0; done
}
alias egc="nvim ~/.gitconfig"
alias sgu="cat ~/.gitconfig | grep email"
function cgu() {
  CHOICE=$(gum choose "jared.corker@gmail.com" "jared.corker@rea-group.com" --cursor.foreground="129")
  if [[ $CHOICE == *"rea-group"* ]]; then
    sed -i '' -e 's/gmail.com/rea-group.com/'  $HOME/.gitconfig
  else
    sed -i '' -e 's/rea-group.com/gmail.com/' $HOME/.gitconfig
  fi
  gum style \
    --foreground 129 --border-foreground 129 --border double \
    --align center --width 40 --margin "1 2" --padding "2 4" \
    'Git user is now:' $CHOICE
}
function tester() {

  function clientTest() {
    gum spin --spinner dot --spinner.foreground 129 --title "Unit testing..." -- yarn run client-test
    if [[ $? -eq 0 ]]; then
      echo "\xE2\x9C\x85 Unit test passed"
    else
      echo "\xE2\x9D\x8C Unit test failed"
    fi
  }
  function unitTest() {
    gum spin --spinner dot --spinner.foreground 129 --title "Unit testing..." -- yarn run unit-test
    if [[ $? -eq 0 ]]; then
      echo "\xE2\x9C\x85 Unit test passed"
    else
      echo "\xE2\x9D\x8C Unit test failed"
    fi
  }
  function integrationTest() {
    gum spin --spinner dot --spinner.foreground 129 --title "Integration testing..." -- yarn run integration-test
    if [[ $? -eq 0 ]]; then
      echo "\xE2\x9C\x85 Integration test passed"
    else
      echo "\xE2\x9D\x8C Integration test failed"
    fi
  }
  function lintTest() {
    gum spin --spinner dot --spinner.foreground 129 --title "Linting..." -- yarn run lint
    if [[ $? -eq 0 ]]; then
      echo "\xE2\x9C\x85 Lint passed"
    else
      echo "\xE2\x9D\x8C Lint failed"
    fi
  }
  function checkTypesTest() {
    gum spin --spinner dot --spinner.foreground 129 --title "Checking types..." -- yarn run check-types
    if [[ $? -eq 0 ]]; then
      echo "\xE2\x9C\x85 Check types passed"
    else
      echo "\xE2\x9D\x8C Check types failed"
    fi
  }

  STARTING_DIR=$(eval "pwd")
  echo $STARTING_DIR
  echo 'Choose a repo:'
  CHOICE=$(gum choose "core-web" "experience-api" "exit" --cursor.foreground="129")
  if [[ $CHOICE == "core-web" ]]; then
    cd ~/Documents/REAx/pca-core-web
  elif [[ $CHOICE == "experience-api" ]]; then
    cd ~/Documents/REAx/pca-experience-api
  else
    return 0
  fi

  echo $CHOICE
  CHOICE2=$(gum choose "unit" "integration" "lint" "check-types" "all" --cursor.foreground="129")
  if [[ $CHOICE2 == "unit" ]]; then
    if [[ $CHOICE == "core-web" ]]; then
      clientTest
    elif [[ $CHOICE == "experience-api" ]]; then
      unitTest
    fi
  elif [[ $CHOICE2 == "integration" ]]; then
    integrationTest
  elif [[ $CHOICE2 == "lint" ]]; then
    lintTest
  elif [[ $CHOICE2 == "check-types" ]]; then
    checkTypesTest
  else
    lintTest
    checkTypesTest
    if [[ $CHOICE == "core-web" ]]; then
      clientTest
    elif [[ $CHOICE == "experience-api" ]]; then
      unitTest
    fi
    integrationTest
  fi
  cd $STARTING_DIR
}
