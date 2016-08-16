module ApplicationHelper
  def sortable(column, title=nil)
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    css_class = column == sort_column ? "current #{sort_direction}" :nil
    link_to title, {sort: column,  direction: direction},{class: css_class}
  end

  def out_of_date?(date)
    if date < Date.today
      return true
    end
    false
  end

  def format_date(date)
    if date == '3000-01-01'.to_date
      return 'INDEFINIDO'
    end
    date
  end
end
