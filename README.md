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


<!-- ユーザー新規登録・ログインのテーブル -->
## usersテーブル  

|Column|Type|Options|
|------|----|-------|
|nickname|string|null:false|
|email|string|null:false, unique:true, index:true|
|password|string|null:false|
|family_name|string|null:false|
|first_name|string|null:false|
|kana_family_name|string|null:false|
|kana_first_name|string|null:false|
|birth_year|integer|null:false|
|birth_month|integer|null:false|
|birth_day|integer|null:false|
|zip_code|integer|null:false|
|prefecture|string|null:false|
|municipality|string|null:false|
|address|string|null:false|
|apartment_name|string||
|phone_number|integer|unique:true|

### Association
has_one: addresses
has_one: credit_card
has_many: products


<!--住所のテーブル-->
## addressesテーブル  

|Column|Type|Options|
|------|----|-------|
|zip_code|integer|null:false|
|prefecture|string|null:false|
|municipality|string|null:false|
|address|string|null:false|
|apartment_name|string||
|phone_number|integer|unique:true|
|user_id|references|null:false, foreign_key:true|

### Association
belongs_to: user


<!-- クレジットカードのテーブル -->
## credit_cardsテーブル

|Column|Type|Options|
|------|----|-------|
|card_number|integer|null:false|
|expiration_month|integer|null:false|  <!--有効期限の月-->
|expiration_year|integer|null:false|  <!--有効期限の年-->
|security_code|integer|null:false|
|user_id|references|null:false, foreign_key:true|

### Association
belongs_to: user


<!-- 商品のテーブル -->
## productsテーブル

|Column|Type|Options|
|------|----|-------|
|products_name|string|null:false|
|seller_name|string|null:false|
|size|string|null:false|
|status|string|null:false|
|shipping_charges|integer|null:false|
|prefucture|string|null:false|
|preparation_day|string|null:false|
|price|integer|null:false|
|introduction|text|null:false|
|user_id|integer|null:false, foreign_key:true|
|category_id|references|null:false|
|brand_id|references|null:false|

### Association
belongs_to: user
belongs_to: category
belongs_to: brand
has_many: images


<!-- カテゴリのテーブル -->
## categoriesテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association
has_many: products


<!-- ブランドのテーブル -->
## brandsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null:false|

### Association
has_many: products


<!-- 画像のテーブル -->
## imagesテーブル

|Column|Type|Options|
|------|----|-------|
|url|string|null:false|
|product_id|references|null:false|

### Association
belongs_to: product








