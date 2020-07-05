### 使用说明

初始化一个实例对象时，会为其赋值默认值

```ruby
class User < ApplicationRecord
  include AttributesDefault
  attributes_set_default_value sex: 'man', created_at: lambda { Time.now }
end
```
初始化一个用户#时会为其生成默认值

```ruby
user = User.new
user.sex #=> 'man'
user.created_at #=> "2020-07-05T17:20:01.747+08:00"  初始化那一刻的时间
```