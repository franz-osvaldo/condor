module ToolQuantitiesHelper
  def sort_by_column(column, title)
    direction = column == sort_col && sort_dire == 'asc' ? 'desc' : 'asc'
    css_class = column == sort_col ? "current #{sort_dire}" :nil
    link_to title, {sort: column,  direction: direction},{class: css_class}
  end
end
