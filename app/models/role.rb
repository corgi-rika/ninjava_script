class Role < ActiveHash::Base
  self.data = [
    { id: 0, name: '学習者 -learner-' },
    { id: 1, name: 'メンター -mentor-' }
  ]

  include ActiveHash::Associations
  has_many :users

end
