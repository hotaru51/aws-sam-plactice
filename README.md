# aws-sam-practice

AWS SAM検証用リポジトリ

## 方針

(しばらくこのREADMEはメモ代わり)

* デプロイまでの操作は単純化する
* ポータビリティ、再現性を保つ
* リソース名をコントールしやすいように極力自分で定義する
    * artifact用のバケットとかも自前でコントロールする
* SAMを分割し、親templateでまとめてデプロイする構成にする

### Pythonの場合

* パッケージ管理は `pipenv` にする

## 準備

`init.sh` を実行する  
現時点ではartifact用バケットの作成のみ

## テンプレート生成

作業端末がx86\_64だったりARM(Apple silicon)だったりする時代なので、一応architectureを指定しておく

```sh
cd sam
sam init -a x86_64
```

## ビルド

個別のSAMのビルド

```sh
cd sam/<個別のSAMプロジェクト>
sam build --use-container
```

## アップロード

`samconfig.toml` の `[*.default.package.parameters]` 内の `resolve_s3` は `false` にしておく

```sh
sam package --output-template-file .aws-sam/cfn-template.yaml --s3-bucket <bucket名>
```

## デプロイ

WIP
