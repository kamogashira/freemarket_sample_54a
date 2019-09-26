# freemarket_sample

## Overview
Copy of an exsiting flea market application, Mercari

## System version
- Ruby 2.5.1,
- Rails  5.0.7.2
- MySQL 5.6 

## Database

### User

|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false, unique: true|
|e-mail|string|null: false, unique: true|
|encrypted_password|string|null: false|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|self_introduction|text||
|provider|string||
|uid|string||
|postal_code|integer|null: false|
|prefecture|string|null: false|
|address_city|string|null: false|
|address_street|string||
|address_building|string||
|phone_number|integer||

#### Association
- has_many :products
- has_many :comments
- has_many :evaluations
- has_one :address
- has_one :credit_card


### Product

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|description|text|null: false|
|category|references|null: false, foreign_key: true|
|brand|string||
|size|references|foreign_key: true|
|condition|string|null: false|
|shipping_charge|string|null: false|
|ship_from|string|null: false|
|shipping_days|string|null: false|
|current_status|integer|null: false|
|buyer|references|foreign_key: { to_table: :users }|
|seller|references|foreign_key: { to_table: :users }|
|payment_method|integer|null: false|
|payment_status|integer|null: false|
|sending_status|integer|null: false|
|receiving_status|integer|null: false|
|like|integer||

#### Association
- has_many :product_images
- has_many :comments
- belongs_to :category
- belongs_to :size


### DeliveryAddresses

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|address_city|string|null: false|
|address_street|string||
|address_building|string||
|phone_number|integer|null: false, limit: 11|

#### Association
- belongs_to :user


### Evaluation

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
|good|integer||
|normal|integer||
|bad|integer||
|comment|string||
|date|date||

#### Association
- belongs_to :user


### Comment

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|
|content|text||
|date|date||

#### Association
- belongs_to :user
- belongs_to :product


### ProductImage

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|image|string||

#### Association
- belongs_to :product


### CreditCard

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|customer_id|string|null: false|
|card_id|string|null: false|

#### Association
- belongs_to :user


### Category

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

#### Association
- has_many :products
- has_ancestry


### Size

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

#### Association
- has_many :products


## ERD
![image](https://user-images.githubusercontent.com/52478242/65475198-96b0dc80-deb9-11e9-9ff0-3f838ead5fa7.png)