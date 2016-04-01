class Bird
  include Mongoid::Document
  field :name, type: String
  field :family, type: String
  field :continents, type: Array
  field :visible, type: Mongoid::Boolean, default: false
  field :added, type: Date
  auto_increment :id

  validates_uniqueness_of :name 
  validates_presence_of [:name, :family, :continents]
  before_save :set_added

  private

  def set_added
    self.added = Time.now.utc.strftime("%Y-%m-%d") 
  end
end
