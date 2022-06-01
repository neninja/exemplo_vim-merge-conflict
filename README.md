# Exemplo prático de solução de conflitos de merge

1. Clone o projeto na branch específica
```sh
git clone --branch conflictme git@github.com:nenitf/exemplo_vim-merge-conflict.git
cd exemplo_vim-merge-conflict
```

2. Force o conflito
```sh
git pull origin pullme --no-rebase
```

3. Opte pelo camiho do `vimdiff`, `vimdiff` adaptado ou do `fugitive`

## Opções de mergetool

> Em todas opções, navegue mais facilmente com `[c` e `]c`

> Caso não tenha finalizado mas queira sair do merge, utilize `:cq` ao invés de `:qa` para avisar ao git que o merge não foi finalizado. Caso tenha saido sem querer com `:qa` e não consiga voltar a usar `git mergetool`, retome o status de "não resolvido" do arquivo com `git update-index --unresolve arquivo_existente.txt`

> Para confirmar em qualquer um dos passos, salve a janela contendo o arquivo que está sendo mergeado com `:wqa`

### Com vimdiff

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

3. Acesse a janela de baixo (<kbd>CTRL</kbd><kbd>W</kbd><kbd>J</kbd>) e utilize a cada demarcação `:diff TIPO_DE_ARQUIVO_COM_A_OPÇÃO_CORRETA`. Sendo: `:diffg LO` para optar pelo **local** e `:diffg RE` para o **remoto**

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

3. Acesse a janela do meio (<kbd>CTRL</kbd><kbd>W</kbd><kbd>J</kbd>) e utilize a cada demarcação `:diff TIPO_DE_ARQUIVO_COM_A_OPÇÃO_CORRETA`. Sendo: `:diffg LO` para optar pelo **local** e `:diffg RE` para o **remoto**

### Fugitive

1. Configure o git mergetool corretamente no `~/.gitconfig`
```gitconfig
[mergetool]
    keepBackup = false
[merge]
    tool = fugitive
[mergetool "fugitive"]
    cmd = vim -f -c \"Gvdiffsplit!\" \"$MERGED\"
```

2. Execute o fugitive com ``git mergetool``

> O terminal renderizará com 3 janelas, sendo: 1) O arquivo LOCAL antes do conflito; 2) O arquivo que está sendo mergeado para o commit; 3) O arquivo vindo do REMOTE. 

3. Alterne entre as janelas que pretende manter um certo trecho (<kbd>CTRL</kbd><kbd>W</kbd><kbd>H</kbd> e <kbd>CTRL</kbd><kbd>W</kbd><kbd>L</kbd>) e utilize a cada demarcação `dp` para atualizar a janela do meio

## Créditos

- [my-favorite-tools-to-resolve-git-merge-conflicts](https://blog.xoxzo.com/2019/03/29/my-favorite-tools-to-resolve-git-merge-conflicts/)
- [vimdiff adaptado](https://stackoverflow.com/a/19780597)
- [fugitive como mergetool](https://stackoverflow.com/a/7313949)
