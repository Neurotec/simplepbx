module ApplicationHelper
end

#TODO :)
class TrueClass
  def to_html
    "<li class=\"fa fa-check\"></li>".html_safe
  end
end

class FalseClass
  def to_html
    "<li class=\"fa fa-remove\"></li>".html_safe
  end
end
