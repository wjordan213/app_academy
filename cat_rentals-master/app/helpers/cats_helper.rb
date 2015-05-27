module CatsHelper
  def cat_default_sex(default_sex)
    @cat.sex == default_sex ? 'checked' : 'unchecked'
  end
end
