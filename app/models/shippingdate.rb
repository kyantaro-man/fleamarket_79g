class Shippingdate < ActiveHash::Base
  include ActiveHash::Associations
  has_many :items
  self.data = [ 
    {id: 0, name: '1〜2日で発送'}, {id: 1, name: '2〜3日で発送'},
    {id: 2, name: '4〜7日で発送'}
  ]

  


end