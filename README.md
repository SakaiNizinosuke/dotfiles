# dotfiles

macOS 用の個人設定です。Homebrew でツールを導入し、GNU Stow で Zsh、tmux、Neovim の設定をホームディレクトリへリンクします。

## 対応環境

- macOS（Apple Silicon / Intel）
- Git が利用できること（macOS の Command Line Tools 版で可）
- インターネット接続

## セットアップ

```sh
git clone https://github.com/SakaiNizinosuke/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

スクリプトは次のものを導入します。

- Homebrew と `Brewfile.brew` / `Brewfile.cask` のパッケージ
- Oh My Zsh、Powerlevel10k、Zsh プラグイン
- tmux Plugin Manager（TPM）と tmux プラグイン
- Zsh、tmux、Neovim、Powerlevel10k のシンボリックリンク

既存の `~/.zshrc`、`~/.tmux.conf`、`~/.p10k.zsh`、`~/.config/nvim` と衝突する場合、Stow は上書きせずエラーで停止します。必要な設定を退避してから、もう一度 `./setup.sh` を実行してください。

セットアップ後に新しいシェルを開始します。

```sh
exec zsh
```

## 更新

リポジトリを更新した後、再度セットアップを実行します。

```sh
git pull
./setup.sh
```

Neovim のプラグインは初回起動時に `lazy.nvim` が導入します。LSP サーバーなども初回起動後に Mason から追加ダウンロードされる場合があります。

tmux のプラグインを手動で更新する場合は、tmux 内で `Ctrl-a`、続けて `U` を押します。新しいプラグインの導入は `Ctrl-a`、続けて `Shift-i` です。

## 構成

```text
Brewfile.brew   CLI ツール
Brewfile.cask   GUI アプリ
zsh/            Zsh と Powerlevel10k
tmux/           tmux
nvim/           Neovim
setup.sh        初期セットアップ
```
