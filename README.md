# Exemplo prático de solução de conflitos de merge

1. Clone o projeto na branch específica
```sh
git clone --branch answers1 git@github.com:nenitf/exemplo_vim-merge-conflict.git
cd exemplo_vim-merge-conflict
```

2. Force o conflito
```sh
git pull origin answers2 --no-rebase
```

## Resolvendo no vim

### [Fugitive](https://github.com/tpope/vim-fugitive) (diretamente no vim)

1. Veja o status com `:G`

2. Acesse o arquivo com *3-way-split* usando `dv` com o cursor no mesmo

> O terminal renderizará com 3 janelas, sendo: 1) O arquivo LOCAL antes do conflito; 2) O arquivo que está sendo mergeado para o commit; 3) O arquivo vindo do REMOTE.

> Alterne entre as janelas com <kbd>CTRL</kbd><kbd>W</kbd><kbd>H</kbd> e <kbd>CTRL</kbd><kbd>W</kbd><kbd>L</kbd> e chunks com `[c` `]c`

3. Resolva e salve o arquivo do meio, possibilidades:
    -  Utilize `dp` no LOCAL ou REMOTE para atualizar a janela do meio
    -  Utilize `:diffg //2` para pegar atualizações do LOCAL ou `:diffg //3` do REMOTE para atualizar a janela do meio
    -  Utilize `d2o` para pegar atualizações do LOCAL ou `d3o` do REMOTE para atualizar a janela do meio

4. Salve o buffer que está sendo mergeado e torneo *staged* dentro de `:G`

## Resolvendo com mergetool

> Caso não tenha finalizado mas queira sair do merge, utilize `:cq` ao invés de `:qa` para avisar ao git que o merge não foi finalizado. Caso tenha saido sem querer com `:qa` e não consiga voltar a usar `git mergetool`, retome o status de "não resolvido" do arquivo com `git update-index --unresolve arquivo_existente.txt` ou cancele tudo com `git merge --abort`

### Com vimdiff/nvimdiff

1. Configure o git mergetool corretamente no `~/.gitconfig`
```gitconfig
[mergetool]
    keepBackup = false
[merge]
    tool = vimdiff
    #conflictstyle = diff3
```

2. Execute o vimdiff com ``git mergetool``

> O terminal renderizará com 4 janelas, sendo as 3 de cima representando em ordem: 1) O arquivo LOCAL antes do conflito; 2) O arquivo BASE (comum) do local e ao remoto; 3) O arquivo vindo do REMOTE. Em baixo como o arquivo está sendo mergeado para o commit

> Alterne entre as janelas com <kbd>CTRL</kbd><kbd>W</kbd><kbd>W</kbd> e chunks com `[c` `]c`

3. Utilize a cada demarcação `:diffg TIPO_DE_ARQUIVO_COM_A_OPÇÃO_CORRETA`. Sendo: `:diffg LO` para optar pelo **local** e `:diffg RE` para o **remoto**

4. Salve o buffer que está sendo mergeado com `:wqa`

### Com vimdiff adaptado

1. Configure o git mergetool corretamente no `~/.gitconfig`
```gitconfig
[mergetool]
    keepBackup = false
[merge]
    tool = merge3
[mergetool "merge3"]
    cmd = vim -d -c \"wincmd l\" \"$LOCAL\" \"$MERGED\" \"$REMOTE\"
```

2. Execute o vimdiff com ``git mergetool``

> O terminal renderizará com 3 janelas, sendo: 1) O arquivo LOCAL antes do conflito; 2) O arquivo que está sendo mergeado para o commit; 3) O arquivo vindo do REMOTE. 

> Alterne entre as janelas com <kbd>CTRL</kbd><kbd>W</kbd><kbd>H</kbd> e <kbd>CTRL</kbd><kbd>W</kbd><kbd>L</kbd> e chunks com `[c` `]c`

3. Utilize a cada demarcação `:diffg TIPO_DE_ARQUIVO_COM_A_OPÇÃO_CORRETA`. Sendo: `:diffg LO` para optar pelo **local** e `:diffg RE` para o **remoto**

4. Salve o buffer que está sendo mergeado com `:wqa`

### Com vimdiff adaptado usando plugin [diffconflicts](https://github.com/whiteinge/diffconflicts)

1. Configure o git mergetool corretamente no `~/.gitconfig`
```gitconfig
[merge]
    tool = diffconflicts
[mergetool "diffconflicts"]
    cmd = nvim -c DiffConflicts \"$MERGED\" \"$BASE\" \"$LOCAL\" \"$REMOTE\"
    trustExitCode = true
    keepBackup = false
```

2. Execute com ``git mergetool``

> O terminal renderizará 2 janelas, sendo: 1) O arquivo que deve ser alterado ja modificado com as alterações antes do conflito (`ours`); 2) O arquivo (sopmente visualização) com as alterações que causaram o conflito

> Navegue entre chunks de diff com `[c` `]c`

3. Atualize a primeira janela com o estado pretendido

4. Salve o buffer da primeira janela e feche o editor para abrir o próximo arquivo a ser resolvido com `:xa`

> Utilize `:cq` para abortar

## Créditos

- [my-favorite-tools-to-resolve-git-merge-conflicts](https://blog.xoxzo.com/2019/03/29/my-favorite-tools-to-resolve-git-merge-conflicts/)
- [vimdiff adaptado](https://stackoverflow.com/a/19780597)
- [fugitive como mergetool](https://stackoverflow.com/a/7313949)
- [fugitive merge conflicts](https://nithinbekal.com/posts/fugitive-merge-conflicts/)
