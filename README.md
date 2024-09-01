# README

# NinjavaScript

## アプリケーション概要
- 日本語学習と先生をサポートする学習支援アプリです。4択クイズ形式で単語を覚えたり、学習の進捗を管理したりすることができます。

## URL
- [https://ninjava-script.onrender.com](https://ninjava-script.onrender.com)

## テスト用アカウント
| ユーザータイプ | メール                | パスワード     |
| -------------- | --------------------- | -------------- |
| 学習者用       | learner@test.com      | learner1234    |
| メンター用     | mentor@test.com       | mentor1234     |

## 利用方法
### 学習者用
1. トップページのヘッダーにある「新規登録」ボタンをクリックし、ユーザー登録を行います。
2. 単語を登録し、クイズに挑戦することで学習を進めます。
3. 学習の進捗は、日報機能を使って記録できます。

### メンター用
1. メンターとして登録すると、学習者の進捗を確認し、フィードバックを送信できます。
2. メンター登録時に一意のコードが発行されます。このコードを学習者に渡し、学習者がそのコードを入力することで紐づけが完了します。

## 機能一覧
| 機能                       | 学習者用ユーザー | メンター用ユーザー | 
|----------------------------|-----------------|------------------|
| ユーザー登録                | ○               | ○                |
| ユーザー編集                | ○               | ○                |
| 単語の登録・編集・削除      | ○               | ○                |
| クイズの解答               | ○               | -                |
| 日報の作成・閲覧           | ○               | ○                |
| 学習進捗の確認・フィードバック | ○               | ○                |

## アプリケーションを作成した背景
- 日本語を学ぶ夫のために、効率的な学習サポートを提供するアプリを開発したいと考えました。夫が使用していた無料の日本語学習アプリには不自然な例文や、学んだ単語を復習する機能が不足していたため、それを補うためのアプリを開発しました。

## 開発環境
- フロントエンド: HTML, CSS, JavaScript
- バックエンド: Ruby on Rails
- データベース: PostgreSQL (開発環境でも使用)
- デプロイ: Render

## ローカルでの動作方法
以下のコマンドを順に実行してください。

```bash
git clone https://github.com/あなたのGitHubアカウント/ninjava_script.git
cd ninjava_script
bundle install
rails db:create db:migrate
rails s


## Users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| role               | integer| null: false               |

- has_many :words
- has_many :quizzes
- has_many :feedbacks
- belongs_to :mentor (optional)

### Words テーブル

| Column    | Type   | Options     |
| -------   | ------ | ----------- |
| word      | string | null: false |
| meaning   | string | null: false |
| example   | text   | null: false |
| hiragana  | string |
| user_id | integer | null: false, foreign_key: true |

- belongs_to :user
- has_many :quizzes

### Quizzes テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| word_id        | integer | null: false, foreign_key: true |
| correct_answer | string | null: false |
| option1        | string | null: false |
| option2        | string | null: false |
| option3        | string | null: false |
| option4        | string | null: false |

- belongs_to :word

### Reports テーブル

| Column              | Type    | Options                   |
| ------------------- | ------- | ------------------------- |
| user_id             | integer | null: false, foreign_key: true |
| total_study_time    | decimal | null: false               |
| good_points         | text    | null: false               |
| improvement_points  | text    | null: false               |
| next_steps          | text    | null: false               |
| next_study_day      | string  | null: false               |
| feedback            | text    |                           |
| mentor_id           | integer | foreign_key: true         |

- belongs_to :user
- belongs_to :mentor

