module GroupsHelper
  def render_group_description
    simple_format(group.description)
  end
end
