# テーブル設計

## users テーブル

| Column             | Type    | Options                 |
| ------------------ | ------- | ----------------------- |
| nickname           | string  | null: false             |
| email              | string  | null: false             |
| encrypted_password | string  | null: false             |
| first_name         | string  | null: false, limimt: 50 |
| last_name          | string  | null: false, limimt: 50 |
| first_name_kana    | string  | null: false, limimt: 50 |
| last_name_kana     | string  | null: false, limimt: 50 |
| birth              | integer | null: false             |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| item_name           | text       | null: false                    |
| item_info           | text       | null: false                    |
| category            | string     | null: false                    |
| sales_status        | string     | null: false                    |
| shipping_fee_status | string     | null: false                    |
| prefecture          | string     | null: false                    |
| scheduled_delivery  | string     | null: false                    |
| price               | integer    | null: false                    |
| tax_price           | integer    | null: false                    |
| profit              | integer    | null: false                    |
| user                | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :order

## orders テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| item                | references | null: false, foreign_key: true |
| shipping_address    | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one    :shipping_address

## shipping_addresses テーブル

| Column      | Type       | Options     |
| ----------- | ---------- | ----------- |
| postal_code | string     | null: false |
| prefecture  | string     | null: false |
| city        | string     | null: false |
| address     | string     | null: false |
| building    | string     | null: false |
| phone_number| integer    | null: false |

### Association

- belongs_to :order
