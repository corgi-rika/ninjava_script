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

