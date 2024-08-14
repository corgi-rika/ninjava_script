# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
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

- has_many :words
- has_many :quizzes
- has_many :feedbacks

## Mentors テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| first_name         | string  | null: false               |
| last_name          | string  | null: false               |
| first_name_kana    | string  | null: false               |
| last_name_kana     | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| user_id            | integer | null: false, foreign_key: true |

- has_many :feedbacks
- belongs_to :user

### Words テーブル

| Column  | Type   | Options     |
| ------- | ------ | ----------- |
| word    | string | null: false |
| meaning | string | null: false |
| example | text   | null: false |
| user_id | integer | null: false, foreign_key: true |


- belongs_to :user
- has_many :quizzes

### Quizzes テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| word_id        | integer | null: false, foreign_key: true |
| question       | string | null: false |
| correct_answer | string | null: false |
| option1        | string | null: false |
| option2        | string | null: false |
| option3        | string | null: false |
| option4        | string | null: false |


- belongs_to :word

### Feedbacks テーブル

| Column    | Type   | Options     |
| --------- | ------ | ----------- |
| feedback  | text   | null: false |
| user_id   | integer | null: false, foreign_key: true |
| mentor_id | integer | null: false, foreign_key: true |


- belongs_to :user
- belongs_to :mentor