# freemarket_sample
hello world
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
|reset_password_token|string|
|reset_password_sent_at|datetime|
|remember_created_at|datetime|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|birthday|date|null: false|
|self_introduction|text||
|provider|string||
|uid|string||


#### Association
- has_many :sns_credentials
- has_one :user_address
- has_one :delivery_address
- accepts_nested_attributes_for :user_address
- has_many :credit_cards
- has_many :products
- has_many :comments
- has_one :evaluation


### Product

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|description|text|null: false|
|category|references|null: false, foreign_key: true|
|brand_id|integer||
|size|references|foreign_key: true|
|condition|integer|null: false|
|shipping_charge|integer|null: false|
|ship_from|integer|null: false|
|shipping_days|integer|null: false|
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
accepts_nested_attributes_for :product_images, allow_destroy: true
- has_many :comments
- has_one :evaluation
- belongs_to :category
- belongs_to :brand, optional: true
- belongs_to :size, optional: true
- belongs_to :seller, class_name: "User" ,optional: true
- belongs_to :buyer, class_name: "User",optional: true


### UserAddress

|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|postal_code|integer|null: false|
|prefecture_id|integer|null: false|
|address_city|string|null: false|
|address_street|string||
|address_building|string||
|phone_number|string|limit: 11|

#### Association
- belongs_to :user, optional: true
- belongs_to_active_hash :prefecture


### DeliveryAddress

|Column|Type|Options|
|------|----|-------|
|first_name|string|null: false|
|last_name|string|null: false|
|first_name_kana|string|null: false|
|last_name_kana|string|null: false|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|address_city|string|null: false|
|address_street|string||
|address_building|string||
|phone_number|integer|null: false, limit: 11|
|user_id|integer|null: false|

#### Association
- belongs_to :user, optional: true
- belongs_to_active_hash :prefecture


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
- belongs_to :product


### Comment

|Column|Type|Options|
|------|----|-------|
|product|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|
|content|text||

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
- belongs_to :user, optional: true

### SnsCredential

|Column|Type|Options|
|------|----|-------|
|provider|string||
|uid|string||
|user_id|integer||

#### Association
- belongs_to :user, optional: true


### Category

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|ancestry|string||

#### Association
- has_many :products
- has_many :category_sizes
- has_many :sizes, through: :category_sizes
- has_ancestry


### Size

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

#### Association
- has_many :products
- has_many :category_sizes
- has_many :categories, through: :category_sizes
has_ancestry


### CategorySize

|Column|Type|Options|
|------|----|-------|
|category_id|integer|limit: 8|
|size_id|integer|limit: 8|

#### Association
- belongs_to :category
- belongs_to :size


## ERD
![image](https://i.gyazo.com/62c1e292beb36f68de64a22f727fb03e.png)
